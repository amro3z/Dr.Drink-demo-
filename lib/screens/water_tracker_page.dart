import 'dart:developer';
import 'package:dr_drink/cubits/weather_cubit/weather_cubit.dart';
import 'package:dr_drink/cubits/weather_cubit/weather_states.dart';
import 'package:dr_drink/screens/splash_screen.dart';
import 'package:dr_drink/screens/water_intake.dart';
import 'package:dr_drink/tips/ai.dart';
import 'package:dr_drink/tips/tip_screen.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import '../component/circle.dart'; // CircleWithShadow widget
import '../component/semi_circle_progress_painter.dart';
import '../logic/user.dart';

class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  final MyUser _user = MyUser.instance;
  int _totalWaterGoal = 0;
  int _totalWaterConsumed = 0;
  double _progress = 0.0;
  String _unit = 'ml';
  List<String> tips = []; // Store tips here
  late final TipService tipService;
  late final WeatherCubit weatherCubit;

  @override
  void initState() {
    super.initState();
    _updateWaterConsumed();
    weatherCubit = WeatherCubit();
    tipService = TipService(weatherCubit: weatherCubit);

    // Fetch weather and use it to load tips
    weatherCubit.getWeather();
    weatherCubit.stream.listen((state) {
      if (state is WeatherLoadedState) {
        fetchTips(); // Fetch tips when weather data is loaded
      }
    });
  }

  // Function to fetch tips from the service
  Future<void> fetchTips() async {
    try {
      List<String> fetchedTips = await tipService.fetchTips();
      setState(() {
        tips = fetchedTips; // Update the tips list
      });
    } catch (e) {
      log('Error fetching tips: $e');
      setState(() {
        tips = ['Error fetching tips. Stay hydrated!']; // Error fallback
      });
    }
  }

  // Function to update the consumed water when returning to the screen
  void _updateWaterConsumed() {
    setState(() {
      log(_user.toMap().toString());
      _totalWaterGoal = _user.tracker.totalWaterGoal!;
      _totalWaterConsumed = _user.tracker.totalWaterConsumed;
      _progress = _user.tracker.getProgress();
      _unit = _user.profile.unit;
    });
  }

  // Helper methods to format water consumption and goals
  String getWaterConsumed() {
    return _unit == 'ml'
        ? '$_totalWaterConsumed'
        : (_totalWaterConsumed / 1000).toStringAsFixed(2);
  }

  String getWaterGoal() {
    return _unit == 'ml'
        ? '/$_totalWaterGoal'
        : '/${(_totalWaterGoal / 1000).toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.03,
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.13,
                    decoration: const BoxDecoration(
                      color: MyColor.lightblue,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/bot.png',
                            width: screenWidth * 0.13,
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          Flexible(
                            child: Text(
                              tips.isNotEmpty ? tips[0] : 'Loading tips...',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w500,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Positioning must be done directly within the Stack
            Positioned(
              top: screenHeight * 0.33,
              child: CustomPaint(
                size: Size(screenWidth * 0.78, screenHeight * 0.2),
                painter: SemiCircleProgressPainter(_progress),
              ),
            ),
            Positioned(
              top: screenHeight * 0.35,
              child: CircleWithShadow(),
            ),
            Positioned(
              top: screenHeight * 0.48,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        getWaterConsumed(),
                        style: TextStyle(
                          color: MyColor.blue,
                          fontFamily: 'Poppins',
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        getWaterGoal(),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        ' $_unit',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Daily Drink Target',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaterIntakeScreen(),
                        ),
                      );
                      _updateWaterConsumed();
                    },
                    child: Image.asset(
                      'assets/icons/drink-cup.png',
                      width: screenWidth * 0.13,
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: screenHeight * 0.3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: 0.35,
                      child: Image.asset(
                        'assets/icons/water-drops.png',
                        width: screenWidth * 0.06,
                      ),
                    ),
                    Image.asset(
                      'assets/icons/water-drops.png',
                      width: screenWidth * 0.06,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
