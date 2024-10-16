import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';

class CircleWithShadow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 330,
        height: 350,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MyColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Subtle shadow color
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
