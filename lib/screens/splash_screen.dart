import 'package:dr_drink/screens/target_screen.dart';
import 'package:dr_drink/widgets/genderWidget.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserInput();
  }

  // Check if the user has already entered their data
  Future<void> _checkUserInput() async {
    await Future.delayed(const Duration(seconds: 4));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if gender (or other data) is stored
    String? gender = prefs.getString('gender');
    double? weight = prefs.getDouble('weight');
    String? wakeUpTime = prefs.getString('wakeUpTime');
    String? breakfastTime = prefs.getString('breakfastTime');
    String? lunchTime = prefs.getString('lunchTime');
    String? dinnerTime = prefs.getString('dinnerTime');
    String? bedTime = prefs.getString('bedTime');

    if (!mounted) return; // Check if the widget is still in the tree

    if (gender != null && weight != null && wakeUpTime != null && bedTime != null) {
      // If user data exists, navigate to the TargetScreen (home screen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TargetScreen()),
      );
    } else {
      // If no user data, navigate to GenderWidget (input screen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GenderWidget()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final logoWidth = screenWidth * 0.2;
    final textFontSize = screenWidth * 0.05;
    final subTextFontSize = screenWidth * 0.018;
    final spacing = screenHeight * 0.002;
    final lottieSize = screenWidth * 0.3;

    return Scaffold(
      backgroundColor: MyColor.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            Image(
              image: const AssetImage('assets/image/logo.png'),
              width: logoWidth,
            ),
            SizedBox(height: spacing),
            Text('Drink Daily',
                style: TextStyle(
                  color: MyColor.white,
                  fontSize: textFontSize,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                )),
            Text('Keep hydrate for healthy life',
                style: TextStyle(
                  color: MyColor.white.withOpacity(0.65),
                  fontSize: subTextFontSize,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                )),
            const Spacer(flex: 1),
            Lottie.asset(
              'assets/animations/loading_animation.json',
              width: lottieSize,
              height: lottieSize,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
