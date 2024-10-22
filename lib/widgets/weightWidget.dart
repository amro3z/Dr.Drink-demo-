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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.035, left: screenWidth * 0.025),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "What's your weight? ( kg )",
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
