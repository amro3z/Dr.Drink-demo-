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
      // Refreshing the total water consumed value
      _totalWaterGoal = _user.tracker!.totalWaterGoal!;
      _totalWaterConsumed = _user.tracker!.totalWaterConsumed;
      _progress = _user.tracker!.getProgress();
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
    return Scaffold(
      backgroundColor: MyColor.white,
      body: Stack(
        alignment: Alignment.center, // Align everything centrally
        children: [
          // Padding with the top section and message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 55),
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    color: MyColor.lightblue,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/bot.png',
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(width: 22),
                      const Text(
                        'Drinking enough water\nboosts energy levels!',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
          Positioned(
            top: 270,
            child: CustomPaint(
              size: const Size(395, 210),
              painter: SemiCircleProgressPainter(
                _progress,
              ),
            ),
          ),
          Positioned(
            top: 305,
            child: CircleWithShadow(),
          ),
          Positioned(
            top: 450,
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        getWaterConsumed(),
                        style: TextStyle(
                            color: MyColor.blue,
                            fontFamily: 'Poppins',
                            fontSize: 35,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        getWaterGoal(),
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 35,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Daily Drink Target',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   '200ml',
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontFamily: 'Poppins',
                  //       fontSize: 17,
                  //       fontWeight: FontWeight.w600),
                  // ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // Navigate to WaterIntakeScreen and await result
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaterIntakeScreen(),
                        ),
                      );
                      // Update the consumed water when returning
                      _updateWaterConsumed();
                    },
                    child: Image.asset(
                      'assets/icons/drink-cup.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
              top: 180,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: 0.35,
                      child: Image.asset(
                        'assets/icons/water-drops.png',
                        width: 35,
                        height: 35,
                      ),
                    ),
                    Image.asset(
                      'assets/icons/water-drops.png',
                      width: 35,
                      height: 35,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
