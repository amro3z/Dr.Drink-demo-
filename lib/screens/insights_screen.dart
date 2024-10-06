import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componnent/navigation_bar.dart';
import '../values/color.dart';

class InsightsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Align(
            alignment: Alignment(0, 0),
            child: Text(
              'Welcome Insights!',
              style: TextStyle(color: MyColor.blue, fontSize: 20),
            ),
          ),
          BottomBar(
            homeOpacity: 0.5,
            historyOpacity: 0.5,
            insightsOpacity: 1,
            avatarOpacity: 0.5,
          ),
        ]));
  }
}
