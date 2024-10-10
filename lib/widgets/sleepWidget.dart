import 'package:dr_drink/shares/shares.dart';

import 'package:flutter/material.dart';

class Sleepwidget extends StatefulWidget {
  static int selectedHour = 11;
  static int selectedMinute = 30;
  static String selectedPeriod = "PM";
  Sleepwidget({super.key});

  @override
  State<Sleepwidget> createState() => _SleepwidgetState();
}

class _SleepwidgetState extends State<Sleepwidget> {
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;
  late FixedExtentScrollController periodController;

  @override
  void initState() {
    super.initState();
    // تعيين الموضع الافتراضي للمتحكمات لعجلة التمرير
    hourController = FixedExtentScrollController(
      initialItem: Sleepwidget.selectedHour - 1, // تعيين الساعات (من 1 إلى 12)
    );
    minuteController = FixedExtentScrollController(
      initialItem: Sleepwidget.selectedMinute, // تعيين الدقائق
    );
    periodController = FixedExtentScrollController(
      initialItem: Sleepwidget.selectedPeriod == "AM" ? 0 : 1, // AM أو PM
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "When you sleep?",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Wheel for hours (12-hour format)
                TimeWheel(
                  height: 400,
                  controller: hourController, // استخدم المتحكم
                  selectedItem: Sleepwidget.selectedHour,
                  start: 1,
                  end: 12,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      Sleepwidget.selectedHour = selected;
                    });
                  },
                ),
                // Separator
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    ":",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Wheel for minutes
                TimeWheel(
                  height: 400,
                  controller: minuteController, // استخدم المتحكم
                  selectedItem: Sleepwidget.selectedMinute,
                  start: 0,
                  end: 59,
                  padWithZero: true,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      Sleepwidget.selectedMinute = selected;
                    });
                  },
                ),
                // Wheel for AM/PM
                AmPmWheel(
                  height: 200,
                  controller: periodController, // استخدم المتحكم
                  selectedItem: Sleepwidget.selectedPeriod,
                  onSelectedItemChanged: (selected) {
                    setState(() {
                      Sleepwidget.selectedPeriod = selected;
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
