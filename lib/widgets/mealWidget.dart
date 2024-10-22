import 'package:flutter/material.dart';
import '../shares/shares.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.035, left: screenWidth * 0.025),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "What’s your usual meals time?",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.065,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.045),
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
      }, context: context,
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
      }, context: context,
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
      }, context: context,
    );
  }
}
