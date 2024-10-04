import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TargetScreen extends StatefulWidget {
  final double? initialQuantity = 50; // just for test

  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  bool _showContent = false;
  String _selectedUnit = '';
  double? _quantity;

  @override
  void initState() {
    super.initState();
    _selectedUnit = 'ml'; // Set default unit to 'ml'

    _quantity = widget.initialQuantity;
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showContent = true;
      });
    });
  }

  void setQuantity(double quantity) {
    setState(() {
      _quantity = quantity;
    });
  }

  double getDisplayedQuantity() {
    if (_selectedUnit == 'ml')
      return _quantity ?? 0.0;
    else
      return (_quantity ?? 0.0) / 1000;
  }

  // void _showAdjustDialog() {
  //   final TextEditingController controller = TextEditingController();
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Adjust Quantity'),
  //         content: TextField(
  //           controller: controller,
  //           keyboardType: TextInputType.number,
  //           decoration: InputDecoration(hintText: 'Enter new quantity'),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               final newQuantity = double.tryParse(controller.text);
  //               if (newQuantity != null) {
  //                 setQuantity(newQuantity);
  //               }
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
            top: screenHeight * 0.71, // Adjust positioning as needed
            left: 0,
            right: 0,
            child: Center(

                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.white.withOpacity(0.55),
                      ),
                      child: Text('Adjust', style: TextStyle(
                        color: MyColor.white
                        ,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: adjustFontSize,
                      ),),
                    ),
            ),
          ),
          // Positioned Divider
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
