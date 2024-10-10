import 'package:flutter/material.dart';
import '../shares/shares.dart';

class Weightwidget extends StatefulWidget {
  static int selectedWeight = 70; // القيمة الافتراضية تبدأ من 70
  const Weightwidget({super.key});

  @override
  State<Weightwidget> createState() => _WeightwidgetState();
}

class _WeightwidgetState extends State<Weightwidget> {
  static late FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    // تحديد الموضع الافتراضي لعجلة التمرير ليبدأ من الوزن 70
    scrollController = FixedExtentScrollController(
        initialItem: Weightwidget.selectedWeight - 40); // موضع الوزن 70
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30.0, left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "What's your weight? ( kg )",
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
            WheelList(
              scroll: scrollController,
              selectedItem: Weightwidget.selectedWeight,
              start: 40,
              end: 200,
              onSelectedItemChanged: (selected) {
                setState(() {
                  Weightwidget.selectedWeight =
                      selected; // تحديث القيمة المختارة
                });
              },
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
