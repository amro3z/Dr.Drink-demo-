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
    super.initState();
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

    final textFontSize = screenWidth * 0.06;
    final subTextFontSize = screenWidth * 0.03;

    // Define the positions based on percentages
    final textTopPosition = screenHeight * 0.22;
    final unitsTopPosition = textTopPosition + (screenHeight * 0.15);
    final dividerTopPosition = unitsTopPosition +
        (screenHeight * 0.1); // Position of the divider below buttons

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
          // Positioned text
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

          // Positioned 'ML' and 'L' buttons
          Positioned(
            top:
                unitsTopPosition, // Position the row vertically where you need it
            left: 0,
            right: 0, // Center the Row horizontally
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centers the buttons horizontally
              children: [
                // 'ML' button
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
                    width: screenWidth *
                        0.04), // Space between 'ML' and 'L' buttons
                // 'L' button
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
        ],
        // Positioned Divider
        Positioned(
            top: dividerTopPosition,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.25,
              child: Divider(
                color: MyColor.white,
                thickness: 1,
              ),
            )),
      ],
    );
  }
}
