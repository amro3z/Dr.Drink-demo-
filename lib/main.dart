// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'widgets/genderWidget.dart';
import 'screens/splash_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HistoryPage(),
    );
  }
}
