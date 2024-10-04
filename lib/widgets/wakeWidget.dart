import 'package:flutter/material.dart';

import 'appbars.dart';
import 'shares.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarWake(context),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "When you wakes up?",
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                  height: 200,
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
