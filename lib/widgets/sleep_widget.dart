import 'package:dr_drink/shares/shares.dart';

import 'package:flutter/material.dart';

class SleepWidget extends StatefulWidget {
  static int selectedHour = 11;
  static int selectedMinute = 30;
  static String selectedPeriod = "PM";
  const SleepWidget({super.key});

  @override
  State<SleepWidget> createState() => _SleepWidgetState();
}

class _SleepWidgetState extends State<SleepWidget> {
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;
  late FixedExtentScrollController periodController;

  @override
  void initState() {
    super.initState();
    hourController = FixedExtentScrollController(
      initialItem: SleepWidget.selectedHour - 1,
    );
    minuteController = FixedExtentScrollController(
      initialItem: SleepWidget.selectedMinute,
    );
    periodController = FixedExtentScrollController(
      initialItem: SleepWidget.selectedPeriod == "AM" ? 0 : 1, // AM / PM
    );
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    periodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.035, left: screenWidth * 0.025),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "When you sleep?",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.065,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Wheel for hours (12-hour format)
                TimeWheel(
                  height: screenHeight * 0.45,
                  controller: hourController,
                  selectedItem: SleepWidget.selectedHour,
                  start: 1,
                  end: 12,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      SleepWidget.selectedHour = selected;
                    });
                  },
                ),
                // Separator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    ":",
                    style: TextStyle(
                      fontSize: screenWidth * 0.15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Wheel for minutes
                TimeWheel(
                  height: screenHeight * 0.45,
                  controller: minuteController,
                  selectedItem: SleepWidget.selectedMinute,
                  start: 0,
                  end: 59,
                  padWithZero: true,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      SleepWidget.selectedMinute = selected;
                    });
                  },
                ),
                // Wheel for AM/PM
                AmPmWheel(
                  height: screenHeight * 0.22,
                  controller: periodController,
                  selectedItem: SleepWidget.selectedPeriod,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      SleepWidget.selectedPeriod = selected;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
