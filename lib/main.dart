// ignore_for_file: prefer_const_constructors
import 'package:dr_drink/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'widgets/genderWidget.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => GenderWidget()),
              );
            },
            child: Image.asset(
              "assets/image/go.png",
              width: 40,
              height: 40,
            ),
          )
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Image(
              image: AssetImage(
                "assets/image/bot 1.png",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Hello,",
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            Text(
              "welcome to your smart water",
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "reminder",
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Here comes a few simple questions before we can",
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "personalize",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    "your daily",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    "goal schedule",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
