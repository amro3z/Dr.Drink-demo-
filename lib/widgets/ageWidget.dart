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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30.0, left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "What is your age?",
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
