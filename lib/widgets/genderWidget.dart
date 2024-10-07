import 'package:flutter/material.dart';

import '../shares/appbars.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarGender(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30.0, left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "What's your gender?",
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
