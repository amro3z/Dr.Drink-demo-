import 'package:dr_drink/widgets/ageWidget.dart';
import 'package:dr_drink/widgets/sleepWidget.dart';
import 'package:dr_drink/widgets/wakeWidget.dart';
import 'package:dr_drink/widgets/weightWidget.dart';
import 'package:flutter/material.dart';

import 'shares.dart';
import 'genderWidget.dart';

class MealWidget extends StatefulWidget {
  static int breakfastHour = 8;
  static int breakfastMinute = 30;
  static String breakfastPeriod = "AM";

  static int lunchHour = 12;
  static int lunchMinute = 00;
  static String lunchPeriod = "PM";

  static int dinnerHour = 7;
  static int dinnerMinute = 00;
  static String dinnerPeriod = "PM";

  const MealWidget({super.key});

  @override
  _MealWidgetState createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  late FixedExtentScrollController breakfastHourController;
  late FixedExtentScrollController breakfastMinuteController;
  late FixedExtentScrollController breakfastPeriodController;

  late FixedExtentScrollController lunchHourController;
  late FixedExtentScrollController lunchMinuteController;
  late FixedExtentScrollController lunchPeriodController;

  late FixedExtentScrollController dinnerHourController;
  late FixedExtentScrollController dinnerMinuteController;
  late FixedExtentScrollController dinnerPeriodController;

  @override
  void initState() {
    super.initState();

    // Breakfast controllers
    breakfastHourController =
        FixedExtentScrollController(initialItem: MealWidget.breakfastHour - 1);
    breakfastMinuteController =
        FixedExtentScrollController(initialItem: MealWidget.breakfastMinute);
    breakfastPeriodController = FixedExtentScrollController(
        initialItem: MealWidget.breakfastPeriod == "AM" ? 0 : 1);

    // Lunch controllers
    lunchHourController =
        FixedExtentScrollController(initialItem: MealWidget.lunchHour - 1);
    lunchMinuteController =
        FixedExtentScrollController(initialItem: MealWidget.lunchMinute);
    lunchPeriodController = FixedExtentScrollController(
        initialItem: MealWidget.lunchPeriod == "AM" ? 0 : 1);

    // Dinner controllers
    dinnerHourController =
        FixedExtentScrollController(initialItem: MealWidget.dinnerHour - 1);
    dinnerMinuteController =
        FixedExtentScrollController(initialItem: MealWidget.dinnerMinute);
    dinnerPeriodController = FixedExtentScrollController(
        initialItem: MealWidget.dinnerPeriod == "AM" ? 0 : 1);
  }

  @override
  void dispose() {
    breakfastHourController.dispose();
    breakfastMinuteController.dispose();
    breakfastPeriodController.dispose();

    lunchHourController.dispose();
    lunchMinuteController.dispose();
    lunchPeriodController.dispose();

    dinnerHourController.dispose();
    dinnerMinuteController.dispose();
    dinnerPeriodController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // إزالة التأثير الظل الخاص بالـ AppBar
        toolbarHeight: 60, // تعديل ارتفاع الـ AppBar
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white, // لون خلفية ثابت للـ AppBar
          ),
        ),
        actions: [
          AppBaricon(
            path: "assets/image/back.png",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Wakewidget()),
              );
            },
          ),
          AppBaricon(
            path: "assets/image/sex (1).png",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const GenderWidget()),
              );
            },
          ),
          AppBaricon(
            path: "assets/image/time 1.png",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Agewidget()),
              );
            },
          ),
          AppBaricon(
            path: "assets/image/weight.png",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Weightwidget()),
              );
            },
          ),
          AppBaricon(
            path: "assets/image/clock.png",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Wakewidget()),
              );
            },
          ),
          AppBaricon(
            path: "assets/image/food-service (1).png",
          ),
          AppBaricon(
            path: "assets/image/moon.png",
          ),
          AppBaricon(
            path: "assets/image/target.png",
          ),
          AppBaricon(
            path: "assets/image/go.png",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Sleepwidget()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30.0, left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "What’s your usual meals time?",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          _buildBreakfastTime(),
          const Spacer(
            flex: 1,
          ),
          _buildLunchTime(),
          const Spacer(
            flex: 1,
          ),
          _buildDinnerTime(),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildBreakfastTime() {
    return buildMealTimeSection(
      hour: MealWidget.breakfastHour,
      minute: MealWidget.breakfastMinute,
      perioed: MealWidget.breakfastPeriod,
      mealLabel: "Breakfast",
      timeLabel:
          "${MealWidget.breakfastHour}:${MealWidget.breakfastMinute.toString().padLeft(2, '0')} ${MealWidget.breakfastPeriod} ",
      hourController: breakfastHourController,
      minuteController: breakfastMinuteController,
      periodController: breakfastPeriodController,
      onHourChanged: (value) {
        setState(() {
          MealWidget.breakfastHour = value;
        });
      },
      onMinuteChanged: (value) {
        setState(() {
          MealWidget.breakfastMinute = value;
        });
      },
      onPeriodChanged: (value) {
        setState(() {
          MealWidget.breakfastPeriod = value;
        });
      },
    );
  }

  Widget _buildLunchTime() {
    return buildMealTimeSection(
      mealLabel: "Lunch",
      timeLabel:
          "${MealWidget.lunchHour}:${MealWidget.lunchMinute.toString().padLeft(2, '0')} ${MealWidget.lunchPeriod} ",
      hour: MealWidget.lunchHour,
      minute: MealWidget.lunchMinute,
      perioed: MealWidget.lunchPeriod,
      hourController: lunchHourController,
      minuteController: lunchMinuteController,
      periodController: lunchPeriodController,
      onHourChanged: (value) {
        setState(() {
          MealWidget.lunchHour = value;
        });
      },
      onMinuteChanged: (value) {
        setState(() {
          MealWidget.lunchMinute = value;
        });
      },
      onPeriodChanged: (value) {
        setState(() {
          MealWidget.lunchPeriod = value;
        });
      },
    );
  }

  Widget _buildDinnerTime() {
    return buildMealTimeSection(
      mealLabel: "Dinner",
      timeLabel:
          "${MealWidget.dinnerHour}:${MealWidget.dinnerMinute.toString().padLeft(2, '0')} ${MealWidget.dinnerPeriod} ",
      hour: MealWidget.dinnerHour,
      minute: MealWidget.dinnerMinute,
      perioed: MealWidget.dinnerPeriod,
      hourController: dinnerHourController,
      minuteController: dinnerMinuteController,
      periodController: dinnerPeriodController,
      onHourChanged: (value) {
        setState(() {
          MealWidget.dinnerHour = value;
        });
      },
      onMinuteChanged: (value) {
        setState(() {
          MealWidget.dinnerMinute = value;
        });
      },
      onPeriodChanged: (value) {
        setState(() {
          MealWidget.dinnerPeriod = value;
        });
      },
    );
  }
}
