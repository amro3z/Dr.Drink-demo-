import 'dart:developer';
import 'package:dr_drink/component/navigation_bar.dart';
import 'package:dr_drink/screens/login_screen.dart';
import 'package:dr_drink/widgets/welcome_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../cubits/weather_cubit/weather_cubit.dart';
import '../cubits/weather_cubit/weather_states.dart';
import '../logic/notifications.dart';
import '../logic/storage.dart';
import '../tips/ai.dart';


class SplashScreen extends StatefulWidget {
  static List<String> tips = [];

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final WeatherCubit weatherCubit;
  late final TipService tipService;
  Storage storage = Storage();

  @override
  void initState() {
    super.initState();

    checkCredentials();

    listenToNotificationStream();

    weatherCubit = WeatherCubit();
    tipService = TipService(weatherCubit: weatherCubit);
    weatherCubit.getWeather();
    weatherCubit.stream.listen((state) {
      if (state is WeatherLoadedState) {
        fetchTipsFromService();
      }
    });
  }


  Future<void> fetchTipsFromService() async {
    try {
      List<String> fetchedTips = await tipService.fetchTips();

      setState(() {
        SplashScreen.tips = fetchedTips;
      });
    } catch (e) {
      log('Error in fetching tips from service: $e');
    }
  }

  void listenToNotificationStream(){
    LocalNotificationService.streamController.stream.listen((notificationResponse)
    {
      log(notificationResponse.payload!.toString());
    },);
  }

  Future<void> checkCredentials() async {
    Future.delayed(const Duration(seconds: 1), () async {
      final currentUser = FirebaseAuth.instance.currentUser;
      bool success = false;

      if (currentUser != null) {
        try {
          log('User is authenticated with Firebase');
          success = await storage.loadUserFromFirestoreAndStoreLocally();
        } catch (e) {
          log('Error loading user from Firestore: $e');
          success = await storage.loadUserFromSharedPrefs();
        }
      }

      // Navigate based on success
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CustomNavigationBar()),
        );
      } else if (currentUser == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else { // User is authenticated but doesn't have data
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
        );
      }
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
