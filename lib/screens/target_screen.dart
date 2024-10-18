import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../cubits/weather_cubit/weather_cubit.dart';
import '../cubits/weather_cubit/weather_states.dart';
import '../values/color.dart';
import '../tips/ai.dart';
import '../tips/tip_screen.dart';

import '../componnent/navigation_bar.dart';
import '../logic/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dr_drink/widgets/ageWidget.dart';
import 'package:dr_drink/widgets/weightWidget.dart';
import 'package:dr_drink/widgets/genderWidget.dart';
import 'package:dr_drink/widgets/wakeWidget.dart';
import 'package:dr_drink/widgets/sleepWidget.dart';
import '../widgets/mealWidget.dart';

class TargetScreen extends StatefulWidget {
  final double? initialQuantity = 50; // just for test

  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState(); // التصحيح هنا
}

class _TargetScreenState extends State<TargetScreen> {
  MyUser? _user;
  bool _showContent = false;
  String _selectedUnit = '';
  double? _quantity;
  late final WeatherCubit weatherCubit;
  late final TipService
      tipService; // يجب تهيئة TipService بعد تهيئة weatherCubit
  List<String> tips = [];

  @override
  void initState() {
    super.initState();
    _storeAndCalculateWaterGoal();
    _selectedUnit = 'ml'; // Set default unit to 'ml'
    _quantity = widget.initialQuantity;

    // تهيئة weatherCubit وبدء جلب حالة الطقس
    weatherCubit = WeatherCubit();

    // تهيئة TipService بعد تهيئة weatherCubit
    tipService = TipService(weatherCubit: weatherCubit);

    weatherCubit.getWeather(); // جلب حالة الطقس

    // إضافة مستمع لتحميل بيانات الطقس قبل استدعاء fetchTipsFromService
    weatherCubit.stream.listen((state) {
      if (state is WeatherLoadedState) {
        fetchTipsFromService(); // جلب النصائح بعد تحميل الطقس
      }
    });

    // إظهار محتوى الشاشة بعد 3 ثوانٍ
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showContent = true;
      });
    });
  }

  // Function to store user inputs in SharedPreferences and calculate water goal and it is async to wait for the SharedPreferences to be ready
  Future<void> _storeAndCalculateWaterGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Store values from your widgets
    int age = Agewidget.selectedAge;
    int weight = Weightwidget.selectedWeight;
    String gender = GenderWidget.gender;
    String wakeUpTime = '${Wakewidget.selectedHour}:${Wakewidget.selectedMinute} ${Wakewidget.selectedPeriod}';
    String breakfastTime = '${MealWidget.breakfastHour}:${MealWidget.breakfastMinute} ${MealWidget.breakfastPeriod}';
    String lunchTime = '${MealWidget.lunchHour}:${MealWidget.lunchMinute} ${MealWidget.lunchPeriod}';
    String dinnerTime = '${MealWidget.dinnerHour}:${MealWidget.dinnerMinute} ${MealWidget.dinnerPeriod}';
    String bedTime = '${Sleepwidget.selectedHour}:${Sleepwidget.selectedMinute} ${Sleepwidget.selectedPeriod}';

    _user = MyUser(gender: gender, weight: weight, age: age, wakeUpTime: wakeUpTime, bedTime: bedTime, breakfastTime: breakfastTime, lunchTime: lunchTime, dinnerTime: dinnerTime);

    log('User data: $age, $weight, $gender, $wakeUpTime, $breakfastTime, $lunchTime, $dinnerTime, $bedTime');

    // Calculate the daily water goal based on weight (default in ml)
    setState(() {
      _quantity = _user!.calculateWaterGoal();
    });
    // Store user to shared preferences
    await prefs.setString("user", json.encode(_user!.toMap()));
    await _saveUserToFirestore(_user!);
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

  // دالة لجلب النصائح من TipService
  Future<void> fetchTipsFromService() async {
    try {
      List<String> fetchedTips = await tipService.fetchTips();

      setState(() {
        tips = fetchedTips;
      });

      if (fetchedTips.isNotEmpty) {
        Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
          TipDisplay.showTipBottomSheet(context, fetchedTips[0]);
        });
      }
    } catch (e) {
      log('Error in fetching tips from service: $e'); // تسجيل أي خطأ يحدث هنا
    }
  }

  // بقية كود TargetScreen كما هو
  void setQuantity(double quantity) {
    setState(() {
      _quantity = quantity;
    });
  }

  double getDisplayedQuantity() {
    if (_selectedUnit == 'ml') {
      return _quantity ?? 0.0;
    } else {
      return (_quantity ?? 0.0) / 1000;
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
                      _selectedUnit = 'ml';
                    });
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
                      _selectedUnit = 'L';
                    });
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
            top: screenHeight * 0.71,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColor.white.withOpacity(0.55),
                ),
                child: Text(
                  'Adjust',
                  style: TextStyle(
                    color: MyColor.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: adjustFontSize,
                  ),
                ),
              ),
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomNavigationBar()));
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: MyColor.blue,
                        fontFamily: 'Poppins',
                        fontSize: subTextFontSize,
                        fontWeight: FontWeight.w700,
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
                '${getDisplayedQuantity()}',
                style: TextStyle(
                  color: MyColor.white,
                  fontFamily: 'Poppins',
                  fontSize: numFontSize,
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
