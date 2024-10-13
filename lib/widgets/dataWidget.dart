import 'package:dr_drink/cubits/weather_cubit/weather_cubit.dart';
import 'package:dr_drink/screens/target_screen.dart';
import 'package:dr_drink/shares/appBarrIcons.dart';
import 'package:dr_drink/values/color.dart';
import 'package:dr_drink/widgets/ageWidget.dart';
import 'package:dr_drink/widgets/genderWidget.dart';
import 'package:dr_drink/widgets/mealWidget.dart';
import 'package:dr_drink/widgets/sleepWidget.dart';
import 'package:dr_drink/widgets/wakeWidget.dart';
import 'package:dr_drink/widgets/weightWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataWidget extends StatefulWidget {
  @override
  _DataWidgetState createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool goPressed = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColor.white,
        actions: [
          buildAppBarIcon("assets/image/back.png", 0),
          buildAppBarIcon("assets/image/gender.png", 0),
          buildAppBarIcon("assets/image/age.png", 1),
          buildAppBarIcon("assets/image/weight.png", 2),
          buildAppBarIcon("assets/image/alarm.png", 3),
          buildAppBarIcon("assets/image/meal.png", 4),
          buildAppBarIcon("assets/image/sleep.png", 5),
          AppBaricon(
            path: "assets/image/go.png",
            onTap: () {
              setState(() {
                goPressed = true;
              });

              // إذا كان المستخدم في تبويبة SleepWidget، الانتقال إلى TargetScreen
              if (_tabController.index == _tabController.length - 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const TargetScreen()),
                );
              } else {
                // الانتقال إلى التبويبة التالية
                if (_tabController.index < _tabController.length - 1) {
                  _tabController.animateTo(_tabController.index + 1);
                }
              }

              // جلب البيانات باستخدام WeatherCubit
              var weather = BlocProvider.of<WeatherCubit>(context);
              weather.getWeather();
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        physics: goPressed
            ? null
            : NeverScrollableScrollPhysics(), // منع السحب بين التبويبات إذا لم يُضغط على "Go"
        children: [
          const Center(
            child: GenderWidget(),
          ),
          const Center(
            child: Agewidget(),
          ),
          const Center(
            child: Weightwidget(),
          ),
          Center(
            child: Wakewidget(),
          ),
          const Center(
            child: MealWidget(),
          ),
          Center(
            child: Sleepwidget(),
          ),
        ],
      ),
    );
  }

  AppBaricon buildAppBarIcon(String path, int index) {
    Color iconColor;
    if (_tabController.index == index) {
      iconColor = MyColor.blue; // التبويبة الحالية
    } else if (_tabController.index > index) {
      iconColor = Colors.black; // التبويبات السابقة
    } else {
      iconColor = Colors.grey; // التبويبات المستقبلية
    }

    return AppBaricon(
      path: path,
      onTap: () {
        if (goPressed || index <= _tabController.index) {
          _tabController
              .animateTo(index); // الانتقال إلى التبويبة إذا كانت مسموحة
        }
      },
      color: iconColor,
    );
  }
}
