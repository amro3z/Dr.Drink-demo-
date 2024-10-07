import 'package:flutter/material.dart';
import '../componnent/navigation_bar.dart';
import '../values/color.dart'; // MyColor definition

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome Home!',
          style: TextStyle(color: MyColor.blue, fontSize: 20),
        ),

      ),
    );
  }
}
