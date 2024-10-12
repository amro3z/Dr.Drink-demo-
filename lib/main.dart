import 'package:dr_drink/screens/login_screen.dart';
import 'package:dr_drink/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/weather_cubit/weather_cubit.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WeatherCubit()..getWeather(), // تأكد من استدعاء getWeather هنا
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  LoginScreen(),
      ),
    );
  }
}
