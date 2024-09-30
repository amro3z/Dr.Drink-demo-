import 'dart:developer';

import 'package:dr_drink/widgets/genderWidget.dart';
import 'package:flutter/material.dart';

import 'appBarrIcons.dart';
import 'weightWidget.dart';

class Agewidget extends StatefulWidget {
  static int selectedAge = 0;
  const Agewidget({super.key});

  @override
  State<Agewidget> createState() => _AgewidgetState();
}

class _AgewidgetState extends State<Agewidget> {
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
                MaterialPageRoute(builder: (context) => const GenderWidget()),
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
              if (Agewidget.selectedAge == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please select a Number")),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Weightwidget()),
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
                  "What's your age?",
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
                    Agewidget.selectedAge = index + 12; // الرقم المختار
                  });
                },
                perspective: 0.003,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    final age = index + 12; // الأرقام من 12 إلى 100
                    return Center(
                      child: Text(
                        age.toString(),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          color: Agewidget.selectedAge == age
                              ? Colors.black
                              : Colors.grey, // تمييز الرقم المختار
                        ),
                      ),
                    );
                  },
                  childCount: 100 - 12 + 1, // الأرقام من 12 إلى 100
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
