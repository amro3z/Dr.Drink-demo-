import 'package:flutter/material.dart';
import '../shares/shares.dart';

class WakeWidget extends StatefulWidget {
  static int selectedHour = 6;
  static int selectedMinute = 30;
  static String formatedMinute = selectedMinute.toString().padLeft(2, '0');
  static String selectedPeriod = "AM";
  const WakeWidget({super.key});

  @override
  State<WakeWidget> createState() => _WakeWidgetState();
}

class _WakeWidgetState extends State<WakeWidget> {
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;
  late FixedExtentScrollController periodController;

  @override
  void initState() {
    super.initState();
    hourController = FixedExtentScrollController(
      initialItem: WakeWidget.selectedHour - 1,
    );
    minuteController = FixedExtentScrollController(
      initialItem: WakeWidget.selectedMinute,
    );
    periodController = FixedExtentScrollController(
      initialItem: WakeWidget.selectedPeriod == "AM" ? 0 : 1,
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
                  "When you wakes up?",
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
                  selectedItem: WakeWidget.selectedHour,
                  start: 1,
                  end: 12,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      WakeWidget.selectedHour = selected;
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
                  selectedItem: WakeWidget.selectedMinute,
                  start: 0,
                  end: 59,
                  padWithZero: true,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      WakeWidget.selectedMinute = selected;
                    });
                  },
                ),
                // Wheel for AM/PM
                AmPmWheel(
                  height: screenHeight * 0.22,
                  controller: periodController,
                  selectedItem: WakeWidget.selectedPeriod,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      WakeWidget.selectedPeriod = selected;
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
