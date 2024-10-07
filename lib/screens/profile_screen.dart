import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componnent/navigation_bar.dart';
import '../values/color.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Align(
            alignment: Alignment(0, 0),
            child: Text(
              'Welcome Profile!',
              style: TextStyle(color: MyColor.blue, fontSize: 20),
            ),
          ),
          // CustomStyledBottomNavBar(
          //
          // ),
        ]));
  }
}
