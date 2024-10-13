import 'package:flutter/material.dart';

import '../values/color.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(children: [
          Align(
            alignment: Alignment(0, 0),
            child: Text(
              'Welcome Insights!',
              style: TextStyle(color: MyColor.blue, fontSize: 20),
            ),
          ),
         
        ]));
  }
}
