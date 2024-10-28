import 'package:flutter/material.dart';
import '../shares/shares.dart';

class WeightWidget extends StatefulWidget {
  static int selectedWeight = 70;
  const WeightWidget({super.key});

  @override
  State<WeightWidget> createState() => _WeightWidgetState();
}

class _WeightWidgetState extends State<WeightWidget> {
  static late FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(
        initialItem: WeightWidget.selectedWeight - 40);
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
              selectedItem: WeightWidget.selectedWeight,
              start: 40,
              end: 200,
              onSelectedItemChanged: (selected) {
                setState(() {
                  WeightWidget.selectedWeight = selected;
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
