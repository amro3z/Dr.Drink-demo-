import 'package:flutter/cupertino.dart';

import '../values/color.dart';
import '../values/icons.dart';

class BuildMonthContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final textHeadSize = scaleFactor * 20;



    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            MyIcon.leftArrow,
            Text(
              'Oct 2024',
              style: TextStyle(
                  color: MyColor.blue,
                  fontFamily: 'Poppins',
                  fontSize: textHeadSize,
                  fontWeight: FontWeight.w700),
            ),
            MyIcon.rightArrow,
          ],
        ),
      ],
    ) ;

  }



}