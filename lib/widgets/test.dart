import 'package:dr_drink/deta/user_deta.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
          "Lunch Time: ${UserDeta.formatTimeOfDay(UserDeta.lunchTime)}\n"
          "Breakfast Time: ${UserDeta.formatTimeOfDay(UserDeta.breakfastTime)}\n"
          "Dinner Time: ${UserDeta.formatTimeOfDay(UserDeta.dinnerTime)}\n"
          "Sleep Time: ${UserDeta.formatTimeOfDay(UserDeta.sleep)}\n"
          "Wake Up Time: ${UserDeta.formatTimeOfDay(UserDeta.wakesup)}\n"
          "Weight: ${UserDeta.weight}\n"
          "Age: ${UserDeta.age}\n"
          "Gender: ${UserDeta.gender}"),
    ));
  }
}
