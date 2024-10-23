import 'dart:developer';

import 'package:dr_drink/screens/insights_data.dart';
import 'package:dr_drink/screens/insights_screen.dart';
import 'package:dr_drink/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/weather_cubit/weather_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dr_drink/logic/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyABLxq1U60vAWE5cIqyqSjb0MIudKiWKQ4',
            appId: '1:710563306562:android:d894e4e55beb2b6c5fe1db',
            messagingSenderId: '710563306562',
            projectId: 'drink-daily-app'));
    log('Firebase successfully connected!');
  } catch (e) {
    log('Firebase connection error: $e');
  }

  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //   } else {
    //     print('User is signed in!');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.init();

    return BlocProvider(
      create: (context) =>
          WeatherCubit()..getWeather(), // تأكد من استدعاء getWeather هنا
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
