import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dr_drink/widgets/ageWidget.dart';
import 'package:dr_drink/widgets/weightWidget.dart';
import 'package:dr_drink/widgets/genderWidget.dart';
import 'package:dr_drink/widgets/wakeWidget.dart';
import 'package:dr_drink/widgets/sleepWidget.dart';
import 'package:dr_drink/logic/user.dart';

import '../widgets/mealWidget.dart';

class TargetScreen extends StatefulWidget {
  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  User? _user;
  bool _showContent = false;
  String _selectedUnit = 'ml';
  double _waterGoal = 0.0; // Water goal in ml

  @override
  void initState() {
    super.initState();
    _storeAndCalculateWaterGoal();
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

    _user = User(gender: gender, weight: weight, age: age, wakeUpTime: wakeUpTime, bedTime: bedTime, breakfastTime: breakfastTime, lunchTime: lunchTime, dinnerTime: dinnerTime);

    await prefs.setInt('age', age);
    await prefs.setInt('weight', weight);
    await prefs.setString('gender', gender);
    await prefs.setString('wakeUpTime', wakeUpTime);
    await prefs.setString('bedTime', bedTime);

    // Calculate the daily water goal based on weight (default in ml)
    setState(() {
      _waterGoal = _user!.calculateWaterGoal();
    });
  }

  // Function to convert between ml and L based on selected unit
  double _getWaterGoalInSelectedUnit() {
    if (_selectedUnit == 'ml') {
      return _waterGoal; //  Default liters
    }
    return _waterGoal / 1000; // Convert to ml
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final textFontSize = screenWidth * 0.04;
    final subTextFontSize = screenWidth * 0.03;

    final verticalSpacing = screenHeight * 0.1;
    final horizontalSpacing = screenWidth * 0.3;

    final horizontalPadding = screenHeight * 0.05;
    final verticalPadding = screenHeight * 0.00;
    final borderRadius = screenHeight * 0.1;

    return Stack(children: [
      Positioned.fill(
          child: Lottie.asset('assets/animations/water_fill_animation.json',
              fit: BoxFit.fill, repeat: false)),
      if (_showContent)
        Column(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: verticalSpacing,
                  ),
                  Text(
                    'Your daily water goal is',
                    style: TextStyle(
                      color: MyColor.white,
                      fontSize: textFontSize,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${_getWaterGoalInSelectedUnit()} $_selectedUnit',
                    style: TextStyle(
                      color: MyColor.white,
                      fontSize: screenWidth * 0.06, // Larger font for water goal
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: verticalSpacing,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
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
                        horizontal: horizontalPadding),
                    decoration: BoxDecoration(
                        color: _selectedUnit == 'ml'
                            ? MyColor.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(borderRadius)),
                    child: Text(
                      'ML',
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
                SizedBox(
                  width: horizontalSpacing,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedUnit = 'L';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: verticalPadding,
                        horizontal: horizontalPadding),
                    decoration: BoxDecoration(
                      color: _selectedUnit == 'L'
                          ? MyColor.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(borderRadius),
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
                )
              ],
            )
          ],
        )
    ]);
  }
}
