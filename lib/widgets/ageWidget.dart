import 'package:flutter/material.dart';
import '../shares/shares.dart';

class Agewidget extends StatefulWidget {
  static int selectedAge = 20; // تعيين القيمة الافتراضية
  const Agewidget({super.key});

  @override
  State<Agewidget> createState() => _AgewidgetState();
}

class _AgewidgetState extends State<Agewidget> {
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // تحديد الموضع الافتراضي للتمرير إلى العمر 20
    _scrollController =
        FixedExtentScrollController(initialItem: Agewidget.selectedAge - 12);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.035, left: screenWidth * 0.025),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "What is your age?",
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
            start: 12,
            end: 100,
            selectedItem: Agewidget.selectedAge, // تمرير القيمة الافتراضية
            onSelectedItemChanged: (selected) {
              setState(() {
                Agewidget.selectedAge = selected; // تحديث القيمة المختارة
              });
            },
            scroll: _scrollController,
          ),
        ],
      ),
    );
  }
}
