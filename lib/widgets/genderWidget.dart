import 'package:flutter/material.dart';

import '../shares/shares.dart';

class GenderWidget extends StatefulWidget {
  static bool isMale = true;
  static bool isFemale = false;
  static String gender = "Male";
  const GenderWidget({super.key});
  @override
  _GenderWidgetState createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
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
                  "What's your gender?",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedGender(
                    path: "assets/image/man.png",
                    text: "Male",
                    isSelected: GenderWidget.isMale,
                    onTap: () {
                      setState(() {
                        GenderWidget.isMale = true;
                        GenderWidget.isFemale = false;
                        GenderWidget.gender = "Male";
                      });
                    }),
                SizedBox(width: screenWidth*0.027,),
                AnimatedGender(
                    path: "assets/image/Female.png",
                    text: "Female",
                    isSelected: GenderWidget.isFemale,
                    onTap: () {
                      setState(() {
                        GenderWidget.isMale = false;
                        GenderWidget.isFemale = true;
                        GenderWidget.gender = "Female";
                      });
                    })
              ],
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
