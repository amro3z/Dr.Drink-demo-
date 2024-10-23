import 'package:flutter/material.dart';
import '../shares/shares.dart';

class Wakewidget extends StatefulWidget {
  static int selectedHour = 6;
  static int selectedMinute = 30;
  static String FormatedMinute = selectedMinute.toString().padLeft(2, '0');
  static String selectedPeriod = "AM";
  Wakewidget({super.key});

  @override
  State<Wakewidget> createState() => _WakewidgetState();
}

class _WakewidgetState extends State<Wakewidget> {
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;
  late FixedExtentScrollController periodController;

  @override
  void initState() {
    super.initState();
    // تعيين الموضع الافتراضي للمتحكمات لعجلة التمرير
    hourController = FixedExtentScrollController(
      initialItem: Wakewidget.selectedHour - 1, // تعيين الساعات (من 1 إلى 12)
    );
    minuteController = FixedExtentScrollController(
      initialItem: Wakewidget.selectedMinute, // تعيين الدقائق
    );
    periodController = FixedExtentScrollController(
      initialItem: Wakewidget.selectedPeriod == "AM" ? 0 : 1, // AM أو PM
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
                  controller: hourController, // استخدم المتحكم
                  selectedItem: Wakewidget.selectedHour,
                  start: 1,
                  end: 12,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      Wakewidget.selectedHour = selected;
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
                  controller: minuteController, // استخدم المتحكم
                  selectedItem: Wakewidget.selectedMinute,
                  start: 0,
                  end: 59,
                  padWithZero: true,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      Wakewidget.selectedMinute = selected;
                    });
                  },
                ),
                // Wheel for AM/PM
                AmPmWheel(
                  height: screenHeight * 0.22,
                  controller: periodController, // استخدم المتحكم
                  selectedItem: Wakewidget.selectedPeriod,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      Wakewidget.selectedPeriod = selected;
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
