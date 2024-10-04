import 'package:dr_drink/widgets/ageWidget.dart';
import 'package:dr_drink/widgets/genderWidget.dart';
import 'package:dr_drink/widgets/wakeWidget.dart';
import 'package:flutter/material.dart';

import 'shares.dart';

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
                MaterialPageRoute(builder: (context) => const Agewidget()),
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
                MaterialPageRoute(builder: (context) => const Agewidget()),
              );
            },
          ),
          AppBaricon(
            path: "assets/image/weight.png",
          ),
          AppBaricon(
            path: "assets/image/clock.png",
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
                MaterialPageRoute(builder: (context) => Wakewidget()),
              );
            },
          ),
        ],
      ),
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
