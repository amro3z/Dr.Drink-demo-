import 'package:flutter/material.dart';

import '../values/color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(children: [
          Align(
            alignment: Alignment(0, 0),
            child: Text(
              'Welcome Profile!',
              style: TextStyle(color: MyColor.blue, fontSize: 20),
            ),
          ),
          
        ]));
  }
}
