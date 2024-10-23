import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../cubits/weather_cubit/weather_cubit.dart';
import '../logic/account.dart';
import '../logic/data.dart';
import '../logic/history.dart';
import '../logic/profile.dart';
import '../logic/tracker.dart';
import '../values/color.dart';
import '../tips/ai.dart';
import '../logic/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dr_drink/widgets/ageWidget.dart';
import 'package:dr_drink/widgets/weightWidget.dart';
import 'package:dr_drink/widgets/genderWidget.dart';
import 'package:dr_drink/widgets/wakeWidget.dart';
import 'package:dr_drink/widgets/sleepWidget.dart';
import 'package:dr_drink/component/navigation_bar.dart';

class TargetScreen extends StatefulWidget {
  final double? initialQuantity = 50; // just for test

  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  MyUser? _user;
  Account? _account;
  bool _showContent = false;
  String _selectedUnit = 'ml';
  int? _quantity;
  late final WeatherCubit weatherCubit;
  late final TipService tipService;
  List<String> tips = [];

  @override
  void initState() {
    super.initState(); // Set default unit to 'm'
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showContent = true;
      });
    });
    // load account from shared preferences
    _loadAccountFromSharedPrefs();

    _fetchUserData();



  }

  // Load account from shared preferences
  Future<void> _loadAccountFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountJson = prefs.getString('account');
    if (accountJson != null) {
      setState(() {
        _account = Account.fromMap(json.decode(accountJson));
      });
    }
  }

  // Function to store user inputs in SharedPreferences and calculate water goal and it is async to wait for the SharedPreferences to be ready
  Future<void> _fetchUserData() async {

    // Store values from your widgets
    int age = Agewidget.selectedAge;
    int weight = Weightwidget.selectedWeight;
    String gender = GenderWidget.gender;
    String wakeUpTime = '${Wakewidget.selectedHour}:${Wakewidget.selectedMinute} ${Wakewidget.selectedPeriod}';
    String bedTime = '${Sleepwidget.selectedHour}:${Sleepwidget.selectedMinute} ${Sleepwidget.selectedPeriod}';

    await _loadAccountFromSharedPrefs();

    setState(() {
      Data data = Data(gender: gender, weight: weight, age: age, wakeUpTime: wakeUpTime, bedTime: bedTime);
      Profile profile = Profile(unit: _selectedUnit);
      History history = History();
      Tracker tracker = Tracker();
      tracker.calculateWaterGoal(weight);
      log(_account!.toMap().toString());
      _user = MyUser(account: _account,data: data, profile: profile, history: history, tracker: tracker);

      _saveUserToSharedPrefs(_user!);
      _saveUserToFirestore(_user!);
      _quantity = tracker.totalWaterGoal;
    });
  }

  Future<void> _saveUserToSharedPrefs(MyUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user.toMap()));
    await prefs.setBool('isUserRegistered', true);
  }

  // Function to Save User to Firestore
  Future<void> _saveUserToFirestore(MyUser user) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('users');
      String userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous'; // Get the user ID if available

      await userCollection.doc(userId).set(user.toMap());

      log('User saved to Firestore successfully.');
    } catch (e) {
      log('Failed to save user to Firestore: $e');
    }
  }

  void setQuantity(int quantity) {
    setState(() {
      _quantity = quantity;
    });
  }

  String getDisplayedQuantity() {
    if (_selectedUnit == 'ml') {
      return '$_quantity';
    } else {
      return (_quantity! / 1000).toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final textFontSize = screenWidth * 0.08;
    final adjustFontSize = screenWidth * 0.04;
    final numFontSize = screenWidth * 0.3;
    final unitFontSize = screenWidth * 0.08;
    final subTextFontSize = screenWidth * 0.04;

    final textTopPosition = screenHeight * 0.22;
    final unitsTopPosition = textTopPosition + (screenHeight * 0.15);
    final dividerTopPosition = unitsTopPosition + (screenHeight * 0.1);

    final horizontalPadding = screenHeight * 0.035;
    final verticalPadding = screenHeight * 0.015;
    final borderRadius = screenHeight * 0.1;

    return Stack(
      children: [
        Positioned.fill(
          child: Lottie.asset(
            'assets/animations/water_fill_animation.json',
            fit: BoxFit.fill,
            repeat: false,
          ),
        ),
        if (_showContent) ...[
          Positioned(
            top: textTopPosition,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Your daily goal is',
                style: TextStyle(
                  color: MyColor.white,
                  fontSize: textFontSize,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Positioned(
            top: unitsTopPosition,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _user?.profile.unit = 'ml';
                      _selectedUnit = 'ml';
                    });
                    _saveUserToSharedPrefs(_user!);
                    _saveUserToFirestore(_user!);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: verticalPadding,
                      horizontal: horizontalPadding,
                    ),
                    decoration: ShapeDecoration(
                      color: _selectedUnit == 'ml'
                          ? MyColor.white
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    child: Text(
                      'ml',
                      style: TextStyle(
                        color: _selectedUnit == 'ml'
                            ? MyColor.blue
                            : MyColor.white,
                        fontSize: subTextFontSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _user?.profile.unit = 'L';
                      _selectedUnit = 'L';
                    });
                    _saveUserToSharedPrefs(_user!);
                    _saveUserToFirestore(_user!);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: verticalPadding,
                      horizontal: horizontalPadding,
                    ),
                    decoration: ShapeDecoration(
                      color: _selectedUnit == 'L'
                          ? MyColor.white
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    child: Text(
                      'L',
                      style: TextStyle(
                        color:
                            _selectedUnit == 'L' ? MyColor.blue : MyColor.white,
                        fontSize: subTextFontSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: dividerTopPosition,
            left: 0,
            right: 0,
            child: const Opacity(
              opacity: 0.25,
              child: Divider(
                color: MyColor.white,
                thickness: 1,
                indent: 50,
                endIndent: 50,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.932,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 290,
                decoration: ShapeDecoration(
                  color: MyColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: (){
                      // need to be changed as they take time which make the navigation to home slow
                      //
                      ///
                      /// //

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CustomNavigationBar()));
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: MyColor.blue,
                        fontFamily: 'Poppins',
                        fontSize: subTextFontSize,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.5,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _selectedUnit == 'ml' ? getDisplayedQuantity() : getDisplayedQuantity(),
                style: TextStyle(
                  color: MyColor.white,
                  fontFamily: 'Poppins',
                  fontSize:  numFontSize,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.615,
            right:
                _selectedUnit == 'ml' ? screenWidth * 0.08 : screenWidth * 0.12,
            child: Text(
              _selectedUnit == 'ml' ? 'ml' : 'L',
              style: TextStyle(
                color: MyColor.white,
                fontFamily: 'Poppins',
                fontSize: unitFontSize,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
