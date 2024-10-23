import 'package:dr_drink/values/color.dart';
import 'package:dr_drink/widgets/dataWidget.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DataWidget()),
              );
            },
            child: Image.asset(
              "assets/image/go.png",
              width: screenWidth * 0.09,
              height: screenWidth * 0.09,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            const Image(
              image: AssetImage(
                "assets/image/bot 1.png",
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text(
              "Hello,",
              style: TextStyle(
                  fontSize: screenWidth * 0.065,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            Text(
              "welcome to your smart water",
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "reminder",
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Here comes a few simple questions before we can",
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontFamily: 'Poppins',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "personalize",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    fontFamily: 'Poppins',
                    color: MyColor.blue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    "your daily",
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    "goal schedule",
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontFamily: 'Poppins',
                      color: MyColor.blue,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
