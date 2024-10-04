import 'package:flutter/material.dart';

import 'appbars.dart';

class GenderWidget extends StatefulWidget {
  static bool isMale = false;
  static bool isFemale = false;
  static String gender = "";
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

class AnimatedGender extends StatelessWidget {
  const AnimatedGender({
    super.key,
    required this.path,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String path;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isSelected ? 1.0 : 0.2,
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              path,
              width: 200,
              height: 200,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 26,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Color(0xff4970CD),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
