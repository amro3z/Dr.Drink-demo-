import 'package:dr_drink/widgets/genderWidget.dart';
import 'package:flutter/material.dart';

import 'welcomeWidget.dart';
import 'ageWidget.dart';
import 'mealWidget.dart';
import 'shares.dart';
import 'sleepWidget.dart';
// import 'test.dart';
import '../screens/target_screen.dart';
import 'wakeWidget.dart';
import 'weightWidget.dart';

AppBar buildAppBarAge(BuildContext context) {
  return AppBar(
    elevation: 0, // إزالة التأثير الظل الخاص بالـ AppBar
    toolbarHeight: 60, // تعديل ارتفاع الـ AppBar
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        color: Colors.white, // لون خلفية ثابت للـ AppBar
      ),
    ),
    actions: [
      AppBaricon(
        path: "assets/image/back.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const GenderWidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/gender.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const GenderWidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/age.png",
        colorIcon: const Color(0xff2A6CE6),
      ),
      AppBaricon(
        path: "assets/image/weight.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/alarm.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/meal.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/sleep.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/target.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/go.png",
        colorIcon: const Color(0xff2A6CE6),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Weightwidget()),
          );
        },
      ),
    ],
  );
}

AppBar buildAppBarGender(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    actions: [
      AppBaricon(
        path: "assets/image/back.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/gender.png",
        colorIcon: const Color(0xff2A6CE6),
      ),
      AppBaricon(
        path: "assets/image/age.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/weight.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/alarm.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/meal.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/sleep.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/target.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/go.png",
        colorIcon: const Color(0xff2A6CE6),
        onTap: () {
          if (GenderWidget.isMale || GenderWidget.isFemale) {
            GenderWidget.gender = GenderWidget.isMale ? "male" : "female";

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Agewidget()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please select a gender")),
            );
          }
        },
      ),
    ],
  );
}

AppBar buildAppBarMeal(BuildContext context) {
  return AppBar(
    elevation: 0, // إزالة التأثير الظل الخاص بالـ AppBar
    toolbarHeight: 60, // تعديل ارتفاع الـ AppBar
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        color: Colors.white, // لون خلفية ثابت للـ AppBar
      ),
    ),
    actions: [
      AppBaricon(
        path: "assets/image/back.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Wakewidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/gender.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const GenderWidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/age.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Agewidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/weight.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Weightwidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/alarm.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Wakewidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/meal.png",
        colorIcon: const Color(0xff2A6CE6),
      ),
      AppBaricon(
        path: "assets/image/sleep.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/target.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/go.png",
        colorIcon: const Color(0xff2A6CE6),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Sleepwidget()),
          );
        },
      ),
    ],
  );
}

AppBar buildAppBarSleep(BuildContext context) {
  return AppBar(
    elevation: 0, // إزالة التأثير الظل الخاص بالـ AppBar
    toolbarHeight: 60, // تعديل ارتفاع الـ AppBar
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        color: Colors.white, // لون خلفية ثابت للـ AppBar
      ),
    ),
    actions: [
      AppBaricon(
        path: "assets/image/back.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MealWidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/gender.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const GenderWidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/age.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Agewidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/weight.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Weightwidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/alarm.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Wakewidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/meal.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MealWidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/sleep.png",
        colorIcon: const Color(0xff2A6CE6),
      ),
      AppBaricon(
        path: "assets/image/target.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/go.png",
        colorIcon: const Color(0xff2A6CE6),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TargetScreen()),
          );
        },
      ),
    ],
  );
}

AppBar buildAppBarWake(BuildContext context) {
  return AppBar(
    elevation: 0, // إزالة التأثير الظل الخاص بالـ AppBar
    toolbarHeight: 60, // تعديل ارتفاع الـ AppBar
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        color: Colors.white, // لون خلفية ثابت للـ AppBar
      ),
    ),
    actions: [
      AppBaricon(
        path: "assets/image/back.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Weightwidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/gender.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const GenderWidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/age.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Agewidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/weight.png",
      ),
      AppBaricon(
        path: "assets/image/alarm.png",
        colorIcon: const Color(0xff2A6CE6),
      ),
      AppBaricon(
        path: "assets/image/meal.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/sleep.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/target.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/go.png",
        colorIcon: const Color(0xff2A6CE6),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MealWidget()),
          );
        },
      ),
    ],
  );
}

AppBar buildAppBarWeight(BuildContext context) {
  return AppBar(
    elevation: 0, // إزالة التأثير الظل الخاص بالـ AppBar
    toolbarHeight: 60, // تعديل ارتفاع الـ AppBar
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        color: Colors.white, // لون خلفية ثابت للـ AppBar
      ),
    ),
    actions: [
      AppBaricon(
        path: "assets/image/back.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Agewidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/gender.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const GenderWidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/age.png",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Agewidget()),
          );
        },
      ),
      AppBaricon(
        path: "assets/image/weight.png",
        colorIcon: const Color(0xff2A6CE6),
      ),
      AppBaricon(
        path: "assets/image/alarm.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/meal.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/sleep.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/target.png",
        colorIcon: const Color.fromARGB(255, 148, 147, 147),
      ),
      AppBaricon(
        path: "assets/image/go.png",
        colorIcon: const Color(0xff2A6CE6),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Wakewidget()),
          );
        },
      ),
    ],
  );
}
