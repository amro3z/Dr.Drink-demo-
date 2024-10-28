import 'package:dr_drink/cubits/weather_cubit/weather_cubit.dart';
import 'package:dr_drink/screens/target_screen.dart';
import 'package:dr_drink/shares/app_barr_icons.dart';
import 'package:dr_drink/values/color.dart';
import 'package:dr_drink/widgets/age_widget.dart';
import 'package:dr_drink/widgets/gender_widget.dart';
import 'package:dr_drink/widgets/meal_widget.dart';
import 'package:dr_drink/widgets/sleep_widget.dart';
import 'package:dr_drink/widgets/wake_widget.dart';
import 'package:dr_drink/widgets/weight_widget.dart';
import 'package:dr_drink/widgets/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataWidget extends StatefulWidget {
  const DataWidget({super.key});

  @override
  DataWidgetState createState() => DataWidgetState();
}

class DataWidgetState extends State<DataWidget>
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
        automaticallyImplyLeading: false, // Hides the back arrow
        actions: [
          AppBarIcon(
            path: "assets/image/back.png",
            onTap: () {
              setState(() {
                goPressed = true;
              });

              if (_tabController.index > 0) {
                _tabController.animateTo(_tabController.index - 1);
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const WelcomePage()));
              }
            },
          ),
          buildAppBarIcon("assets/image/gender.png", 0),
          buildAppBarIcon("assets/image/age.png", 1),
          buildAppBarIcon("assets/image/weight.png", 2),
          buildAppBarIcon("assets/image/alarm.png", 3),
          buildAppBarIcon("assets/image/meal.png", 4),
          buildAppBarIcon("assets/image/sleep.png", 5),
          AppBarIcon(
            path: "assets/image/go.png",
            onTap: () {
              setState(() {
                goPressed = true;
              });

              if (_tabController.index == _tabController.length - 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const TargetScreen()),
                );

                var weather = BlocProvider.of<WeatherCubit>(context);
                weather.getWeather();
              } else {
                if (_tabController.index < _tabController.length - 1) {
                  _tabController.animateTo(_tabController.index + 1);
                }
              }
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Center(
            child: GenderWidget(),
          ),
          const Center(
            child: AgeWidget(),
          ),
          const Center(
            child: WeightWidget(),
          ),
          Center(
            child: WakeWidget(),
          ),
          const Center(
            child: MealWidget(),
          ),
          Center(
            child: SleepWidget(),
          ),
        ],
      ),
    );
  }

  AppBarIcon buildAppBarIcon(String path, int index) {
    Color iconColor;

    if (_tabController.index == index) {
      iconColor = MyColor.blue;
    } else if (_tabController.index > index) {
      iconColor = Colors.black;
    } else {
      iconColor = Colors.grey;
    }

    return AppBarIcon(
      path: path,
      onTap: () {
        if (goPressed || index <= _tabController.index) {
          setState(() {
            _tabController.animateTo(index);
          });
        }
      },
      color: iconColor,
    );
  }
}
