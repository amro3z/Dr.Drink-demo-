import 'package:dr_drink/widgets/ageWidget.dart';
import 'package:dr_drink/widgets/genderWidget.dart';
import 'package:dr_drink/widgets/wakeWidget.dart';
import 'package:flutter/material.dart';

import 'appBarrIcons.dart';

class Weightwidget extends StatefulWidget {
  static int selectedWeight = 0; // القيمة الافتراضية تبدأ من 40
  const Weightwidget({super.key});

  @override
  State<Weightwidget> createState() => _WeightwidgetState();
}

class _WeightwidgetState extends State<Weightwidget> {
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
              if (Weightwidget.selectedWeight == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please select a Number")),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Wakewidget()),
                );
              }
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
            SizedBox(
              height: 400,
              child: ListWheelScrollView.useDelegate(
                itemExtent: 50, // المسافة بين كل عنصر
                onSelectedItemChanged: (index) {
                  setState(() {
                    Weightwidget.selectedWeight =
                        index + 40; // الرقم المختار يبدأ من 40
                  });
                },
                perspective: 0.003,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    final weight = index + 40; // الأرقام تبدأ من 40
                    return Center(
                      child: Text(
                        weight.toString(),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          color: Weightwidget.selectedWeight == weight
                              ? Colors.black
                              : Colors.grey, // تمييز الرقم المختار
                        ),
                      ),
                    );
                  },
                  childCount: 200 - 40 + 1, // الأرقام من 40 إلى 200
                ),
              ),
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
