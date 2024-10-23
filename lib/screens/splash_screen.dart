import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_drink/component/navigation_bar.dart';
import 'package:dr_drink/screens/login_screen.dart';
import 'package:dr_drink/widgets/welcomeWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../cubits/weather_cubit/weather_cubit.dart';
import '../cubits/weather_cubit/weather_states.dart';
import '../logic/notifications.dart';
import '../logic/user.dart';
import '../tips/ai.dart';


class SplashScreen extends StatefulWidget {
  static List<String> tips = [];

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final WeatherCubit weatherCubit;
  late final TipService tipService; // يجب تهيئة TipService بعد تهيئة weatherCubit
  @override
  void initState() {
    super.initState();
    listenToNotificationStream();
    checkCredentials();

    weatherCubit = WeatherCubit();

    // تهيئة TipService بعد تهيئة weatherCubit
    tipService = TipService(weatherCubit: weatherCubit);

    weatherCubit.getWeather(); // جلب حالة الطقس

    // إضافة مستمع لتحميل بيانات الطقس قبل استدعاء fetchTipsFromService
    weatherCubit.stream.listen((state) {
      if (state is WeatherLoadedState) {
        fetchTipsFromService(); // جلب النصائح بعد تحميل الطقس
      }
    });
  }


  Future<void> fetchTipsFromService() async {
    try {
      List<String> fetchedTips = await tipService.fetchTips();

      setState(() {
        SplashScreen.tips = fetchedTips;
      });

      // if (fetchedTips.isNotEmpty) {
      //   Future.delayed(const Duration(seconds: 1), () {
      //     TipDisplay.showTipBottomSheet(context, fetchedTips[0]);
      //   });
      // }
    } catch (e) {
      log('Error in fetching tips from service: $e'); // تسجيل أي خطأ يحدث هنا
    }
  }

  void listenToNotificationStream(){
    LocalNotificationService.streamController.stream.listen( (notificationResponse)
    {
      log(notificationResponse.payload!.toString());
    },
    );
  }

  Future<void> checkCredentials() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      log('****************************offline');
      _checkUserAuthLocaly();
    } else {
      log('****************************online');
      Future.delayed(const Duration(seconds: 1), () async { // added async
        if (FirebaseAuth.instance.currentUser == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          await _loadUserFromFirestoreAndStoreLocally();
        }
      });
    }
  }

  // Check if the user has already entered their data
  Future<void> _checkUserAuthLocaly() async {
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isUserRegistered = prefs.getBool('isUserRegistered');


    if (!mounted) return; // Check if the widget is still in the tree

    if (isUserRegistered == true) {

      await _loadUserFromSharedPrefs();

      // If user data exists, navigate to the TargetScreen (home screen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CustomNavigationBar()),
      );
    } else {
      // If no user data, navigate to GenderWidget (input screen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  Future<void> _loadUserFromFirestoreAndStoreLocally() async {
    try {
      // Get the authenticated user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;
      log(userId);

      // Reference to the user's document in Firestore
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      // Fetch user data from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await userDoc.get();
      log('second here');
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data()!;
        log(json.encode(userData));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("user", json.encode(userData));
        await prefs.setBool('isUserRegistered', true);

        MyUser user = MyUser.fromMap(userData);
        user.tracker.calculateWaterGoal(user.data.weight!);
        // LocalNotificationService.setNotificationSound(user.profile.notificationSound);

        log(user.toString()); // didnt loged

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CustomNavigationBar()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
        );
      }
    } catch (e) {
      log('Error loading user from Firestore: $e');
    }
  }

  // load user from shared prefs
  Future<void> _loadUserFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyUser user = MyUser.fromMap(json.decode(prefs.getString('user')!));
    log("user loaded from shared prefs");
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
