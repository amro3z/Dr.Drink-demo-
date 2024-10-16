import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';

import '../componnent/circle.dart'; // CircleWithShadow widget
import '../componnent/semi_circle_progress_painter.dart'; // Semi-circle painter

class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
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
              painter: SemiCircleProgressPainter(0.5),
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
                        '1500',
                        style: TextStyle(
                            color: MyColor.blue,
                            fontFamily: 'Poppins',
                            fontSize: 35,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '/3000ml',
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
                  Text(
                    '200ml',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/icons/drink-cup.png',
                    width: 60,
                    height: 60,
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
