import 'dart:convert';
import 'dart:developer';

import 'package:dr_drink/screens/water_intake.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';

import '../componnent/circle.dart'; // CircleWithShadow widget
import '../componnent/semi_circle_progress_painter.dart'; // Semi-circle painter
import 'package:shared_preferences/shared_preferences.dart';

import '../logic/tracker.dart';
import '../logic/user.dart';

class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  final MyUser _user = MyUser.instance;
  int _totalWaterGoal = 0;
  int _totalWaterConsumed = 0;
  double _progress = 0.0;
  String _unit = 'ml';

  @override
  void initState() {
    super.initState();
    // Tracker tracker = Tracker(cupSize: 200, totalWaterGoal: user.calculateWaterGoal());
    _updateWaterConsumed();
  }

  // Function to update the consumed water when coming back
  void _updateWaterConsumed() {
    setState(() {
      log(_user.toMap().toString());
      // Refreshing the total water consumed value
      _totalWaterGoal = _user.tracker.totalWaterGoal!;
      _totalWaterConsumed = _user.tracker.totalWaterConsumed;
      _progress = _user.tracker.getProgress();
      _unit = _user.unit!;

    });
  }

  String getWaterConsumed() {
    return _unit == 'ml'
        ? '$_totalWaterConsumed'
        : (_totalWaterConsumed / 1000).toStringAsFixed(2);
  }

  String getWaterGoal() {
    return _unit == 'ml'
        ? '/$_totalWaterGoal'
        : '/${(_totalWaterGoal / 1000).toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.15,
                    decoration: const BoxDecoration(
                      color: MyColor.lightblue,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/bot.png',
                          width: screenWidth * 0.15,
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        Flexible(
                          child: Text(
                            'Drinking enough water\nboosts energy levels!',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Positioned(

                top: screenHeight * 0.3,
                child: CustomPaint(
                  size: Size(screenWidth * 0.94, screenHeight * 0.25),
                  painter: SemiCircleProgressPainter(_progress),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.35,
              child: CircleWithShadow(),
            ),
            Positioned(
              top: screenHeight * 0.5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        getWaterConsumed(),
                        style: TextStyle(
                          color: MyColor.blue,
                          fontFamily: 'Poppins',
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        getWaterGoal(),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        ' $_unit',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Daily Drink Target',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaterIntakeScreen(),
                        ),
                      );
                      _updateWaterConsumed();
                    },
                    child: Image.asset(
                      'assets/icons/drink-cup.png',
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.08,
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: screenHeight * 0.35,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: 0.35,
                      child: Image.asset(
                        'assets/icons/water-drops.png',
                        width: screenWidth * 0.07,
                      ),
                    ),
                    Image.asset(
                      'assets/icons/water-drops.png',
                      width: screenWidth * 0.07,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  }
