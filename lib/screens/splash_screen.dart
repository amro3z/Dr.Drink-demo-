import 'dart:developer';

import 'package:dr_drink/componnent/navigation_bar.dart';
import 'package:dr_drink/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkCredentials();
  }

  Future<void> checkCredentials() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      log('****************************offline');
      _checkUserAuthLocaly();
    } else {
      log('****************************online');
      Future.delayed(const Duration(seconds: 3), () {
        if (FirebaseAuth.instance.currentUser == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CustomNavigationBar()),
          );
        }
      });
    }
  }

  // Check if the user has already entered their data
  Future<void> _checkUserAuthLocaly() async {
    await Future.delayed(const Duration(seconds: 4));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isUserRegistered = prefs.getBool('isUserRegistered');

    if (!mounted) return; // Check if the widget is still in the tree

    if (isUserRegistered == true) {
      // If user data exists, navigate to the TargetScreen (home screen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomNavigationBar()),
      );
    } else {
      // If no user data, navigate to GenderWidget (input screen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final logoWidth = screenWidth * 0.5;
    final textFontSize = screenWidth * 0.1;
    final subTextFontSize = screenWidth * 0.04;
    final spacing = screenHeight * 0.002;
    final lottieSize = screenWidth * 0.3;
    return Scaffold(
      backgroundColor: MyColor.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            Image(
              image: const AssetImage('assets/image/logo.png'),
              width: logoWidth,
            ),
            SizedBox(
              height: spacing,
            ),
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
            const Spacer(
              flex: 1,
            ),
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
