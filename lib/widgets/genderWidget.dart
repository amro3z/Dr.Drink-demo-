import 'package:flutter/material.dart';
import '../main.dart';
import 'ageWidget.dart';
import 'shares.dart';

class GenderWidget extends StatefulWidget {
  static bool isMale = true;  // Male is selected by default
  static bool isFemale = false;
  static String gender = "male";  // Default gender is male

  const GenderWidget({super.key});

  @override
  _GenderWidgetState createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          AppBaricon(
            path: "assets/image/back.png",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeApp()),
              );
            },
          ),
          AppBaricon(
            path: "assets/image/sex (1).png",
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
              if (GenderWidget.isMale || GenderWidget.isFemale) {
                GenderWidget.gender = GenderWidget.isMale ? "male" : "female";

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Agewidget()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please select a gender")),
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
