import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TargetScreen extends StatefulWidget {
  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  bool _showContent = false;
  String _selectedUnit = '';

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showContent = true;
      });
    });
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
                    'Your daily goal is',
                    style: TextStyle(
                      color: MyColor.white,
                      fontSize: textFontSize,
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
