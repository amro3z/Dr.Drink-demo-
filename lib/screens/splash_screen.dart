import '../widgets/welcomeWidget.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    });
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
      body: GestureDetector(
        onTap: () {
          Future.delayed(const Duration(seconds: 3), () {
             Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage() ),
          );

          });
         
        },
        child: Center(
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
      ),
    );
  }
}
