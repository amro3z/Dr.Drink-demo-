import 'package:dr_drink/widgets/ageWidget.dart';
import 'package:dr_drink/widgets/mealWidget.dart';
import 'package:dr_drink/widgets/wakeWidget.dart';
import 'package:flutter/material.dart';

import 'genderWidget.dart';
import 'sleepWidget.dart';
import 'weightWidget.dart';

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "age: ${Agewidget.selectedAge} \n weight: ${Weightwidget.selectedWeight}/n sex: ${GenderWidget.gender} \n wakes up: ${Wakewidget.selectedHour}:${Wakewidget.FormatedMinute} ${Wakewidget.selectedPeriod} \n breakFast: ${MealWidget.breakfastHour}:${MealWidget.breakfastMinute}  ${MealWidget.breakfastPeriod}\n lunch: ${MealWidget.lunchHour}:${MealWidget.lunchMinute} ${MealWidget.lunchPeriod} \n dinner: ${MealWidget.dinnerHour}:${MealWidget.dinnerMinute} ${MealWidget.dinnerPeriod} \n sleep: ${Sleepwidget.selectedHour}:${Sleepwidget.selectedMinute} ${Sleepwidget.selectedPeriod}",
        ),
      ),
    );
  }
}
