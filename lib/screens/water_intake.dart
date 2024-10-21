import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_drink/values/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logic/history.dart';
import '../logic/user.dart';

class WaterIntakeScreen extends StatefulWidget {
  // static List<int> records = [];
  // static List<String> recordedTimes = [];

  @override
  _WaterIntakeScreenState createState() => _WaterIntakeScreenState();

  WaterIntakeScreen({super.key});
}

class _WaterIntakeScreenState extends State<WaterIntakeScreen> {
  String? unit;
  double waterLevel = 50;
  DateTime? recordedTime;
  final MyUser _user = MyUser.instance;
  final History _history = History.instance;



  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      double newWaterLevel = waterLevel - details.delta.dy / 3;
      waterLevel = newWaterLevel.clamp(5.0, 100.0);
    });
  }

  Future<void> _saveUserToSharedPrefs(MyUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user.toMap()));
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

  // function to save history to shared prefs
  Future<void> _saveHistoryToSharedPrefs(History history) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('history', json.encode(history.toMap()));
  }

  // function to save history to firestore
  Future<void> _saveHistoryToFirestore(History history) async {
    try {
      final historyCollection = FirebaseFirestore.instance.collection('history');
      String userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous'; // Get the user ID if available

      await historyCollection.doc(userId).set(history.toMap());

      log('History saved to Firestore successfully.');
    } catch (e) {
      log('Failed to save history to Firestore: $e');
    }
  }

  void _storeRecord() {
    recordedTime = DateTime.now();
    int hours = recordedTime!.hour > 12 ? recordedTime!.hour - 12 : recordedTime!.hour;
    String minutes = recordedTime!.minute.toString();
    if (recordedTime!.minute < 10) {
      minutes = '0${recordedTime!.minute}';
    }

    int record = unit == 'ml' ? (waterLevel * 2).truncate() : (waterLevel * 0.2).truncate()*10 ;
    _user.tracker.drink(record);
    _history.addRecord(record, '$hours:$minutes ${recordedTime!.hour > 12 ? 'PM' : 'AM'}');
    _history.addHourlyConsumption(recordedTime!.hour, record);
    _history.addWeeklyConsumption(recordedTime!.weekday, record);
    _history.addMonthlyConsumption(recordedTime!.day, record);

    _saveUserToSharedPrefs(_user);
    _saveUserToFirestore(_user);
    _saveHistoryToSharedPrefs(_history);
    _saveHistoryToFirestore(_history);
    setState(() {
      // _history.records.add(record); //
      // _history.recordedTimes.add('$hours:$minutes ${recordedTime!.hour > 12 ? 'PM' : 'AM'}');
    });
    log('Water intake records: ${_history.records.toString()}');
    // make a snackbar at top of the screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recorded $record ${unit == 'ml' ? 'ml' : 'L'} at $hours:$minutes ${recordedTime!.hour > 12 ? 'PM' : 'AM'}'),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _getAmount() {
    // ml or letter
    return unit == 'ml' ? '${(waterLevel * 2).toInt()} ml' : '${(waterLevel * 0.002).toStringAsFixed(2)} L';
  }

  @override
  void initState() {
    super.initState();
    unit = _user.unit??'ml';
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical:screenHeight*0.05 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.13,
              decoration: const BoxDecoration(
                color:  MyColor.lightblue,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/bot.png',
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  const Flexible(
                    child: Text(
                      'Drinking enough water\nboosts energy levels!',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: screenWidth * 0.65,
                  height: screenHeight * 0.4,
                  decoration: BoxDecoration(
                    color: MyColor.backcupblue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: screenWidth * 0.65,
                    height: (waterLevel / 100) * (screenHeight * 0.4),
                    decoration: BoxDecoration(
                      color: MyColor.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  bottom: (waterLevel / 100) * (screenHeight * 0.35) - 25,
                  child: GestureDetector(
                    onPanUpdate: _onDragUpdate,
                    child: CircleAvatar(
                      radius: screenWidth * 0.08,
                      backgroundColor: MyColor.dragblue,
                      child: const Icon(
                        Icons.drag_handle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              _getAmount(),
              style: TextStyle(
                  fontSize: screenWidth * 0.12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.13,
                  height: screenWidth * 0.13,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: CircleBorder(),
                  ),
                  child: Center(
                    child: Image.asset('assets/icons/cup_converter.png',
                        width: screenWidth * 0.1, height: screenWidth * 0.1),
                  ),
                ),
                const Spacer(flex: 1),
                Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.08,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        MyColor.gradientlightblue,
                        MyColor.gradientdarktblue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      _storeRecord();
                      Navigator.pop(context);
                    },

                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/plus.png',
                          width: screenWidth * 0.055,
                          height: screenWidth * 0.055,
                        ),
                        SizedBox(
                          width: screenWidth * 0.03,
                        ),
                        Text(
                          'Drink',
                          style: TextStyle(
                              color: MyColor.white,
                              fontFamily: 'Poppins',
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 1),
                Container(
                  width: screenWidth * 0.09,
                  height: screenWidth * 0.09,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: CircleBorder(),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/history.png',
                      width: screenWidth * 0.06,
                      height: screenWidth * 0.06,
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}