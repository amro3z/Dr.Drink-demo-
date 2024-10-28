import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';

class CircleWithShadow extends StatelessWidget {
  const CircleWithShadow({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double circleSize = screenWidth * 0.7;

    return Center(
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MyColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
