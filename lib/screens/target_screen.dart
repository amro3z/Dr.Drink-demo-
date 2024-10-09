import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../cubits/weather_cubit/weather_cubit.dart';
import '../cubits/weather_cubit/weather_states.dart';
import '../values/color.dart';
import '../tips/ai.dart';
import '../tips/tip_screen.dart';

import '../componnent/navigation_bar.dart';

class TargetScreen extends StatefulWidget {
  final double? initialQuantity = 50; // just for test

  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState(); // التصحيح هنا
}

class _TargetScreenState extends State<TargetScreen> {
  bool _showContent = false;
  String _selectedUnit = '';
  double? _quantity;
  late final WeatherCubit weatherCubit;
  late final TipService
      tipService; // يجب تهيئة TipService بعد تهيئة weatherCubit
  List<String> tips = [];

  @override
  void initState() {
    super.initState();
    _selectedUnit = 'ml'; // Set default unit to 'ml'
    _quantity = widget.initialQuantity;

    // تهيئة weatherCubit وبدء جلب حالة الطقس
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

    // إظهار محتوى الشاشة بعد 3 ثوانٍ
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showContent = true;
      });
    });
  }

  // دالة لجلب النصائح من TipService
  Future<void> fetchTipsFromService() async {
    try {
      List<String> fetchedTips = await tipService.fetchTips();

      setState(() {
        tips = fetchedTips;
      });

      if (fetchedTips.isNotEmpty) {
        Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
          TipDisplay.showTipBottomSheet(context, fetchedTips[0]);
        });
      }
    } catch (e) {
      log('Error in fetching tips from service: $e'); // تسجيل أي خطأ يحدث هنا
    }
  }

  // بقية كود TargetScreen كما هو
  void setQuantity(double quantity) {
    setState(() {
      _quantity = quantity;
    });
  }

  double getDisplayedQuantity() {
    if (_selectedUnit == 'ml') {
      return _quantity ?? 0.0;
    } else {
      return (_quantity ?? 0.0) / 1000;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final textFontSize = screenWidth * 0.08;
    final adjustFontSize = screenWidth * 0.04;
    final numFontSize = screenWidth * 0.3;
    final unitFontSize = screenWidth * 0.08;
    final subTextFontSize = screenWidth * 0.04;

    final textTopPosition = screenHeight * 0.22;
    final unitsTopPosition = textTopPosition + (screenHeight * 0.15);
    final dividerTopPosition = unitsTopPosition + (screenHeight * 0.1);

    final horizontalPadding = screenHeight * 0.035;
    final verticalPadding = screenHeight * 0.015;
    final borderRadius = screenHeight * 0.1;

    return Stack(
      children: [
        Positioned.fill(
          child: Lottie.asset(
            'assets/animations/water_fill_animation.json',
            fit: BoxFit.fill,
            repeat: false,
          ),
        ),
        if (_showContent) ...[
          Positioned(
            top: textTopPosition,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Your daily goal is',
                style: TextStyle(
                  color: MyColor.white,
                  fontSize: textFontSize,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Positioned(
            top: unitsTopPosition,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedUnit = 'ml';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: verticalPadding,
                      horizontal: horizontalPadding,
                    ),
                    decoration: ShapeDecoration(
                      color: _selectedUnit == 'ml'
                          ? MyColor.white
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    child: Text(
                      'ml',
                      style: TextStyle(
                        color: _selectedUnit == 'ml'
                            ? MyColor.blue
                            : MyColor.white,
                        fontSize: subTextFontSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedUnit = 'L';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: verticalPadding,
                      horizontal: horizontalPadding,
                    ),
                    decoration: ShapeDecoration(
                      color: _selectedUnit == 'L'
                          ? MyColor.white
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    child: Text(
                      'L',
                      style: TextStyle(
                        color:
                            _selectedUnit == 'L' ? MyColor.blue : MyColor.white,
                        fontSize: subTextFontSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.71,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColor.white.withOpacity(0.55),
                ),
                child: Text(
                  'Adjust',
                  style: TextStyle(
                    color: MyColor.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: adjustFontSize,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: dividerTopPosition,
            left: 0,
            right: 0,
            child: const Opacity(
              opacity: 0.25,
              child: Divider(
                color: MyColor.white,
                thickness: 1,
                indent: 50,
                endIndent: 50,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.932,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 290,
                decoration: ShapeDecoration(
                  color: MyColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomNavigationBar()));
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: MyColor.blue,
                        fontFamily: 'Poppins',
                        fontSize: subTextFontSize,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.5,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${getDisplayedQuantity()}',
                style: TextStyle(
                  color: MyColor.white,
                  fontFamily: 'Poppins',
                  fontSize: numFontSize,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.615,
            right:
                _selectedUnit == 'ml' ? screenWidth * 0.08 : screenWidth * 0.12,
            child: Text(
              _selectedUnit == 'ml' ? 'ml' : 'L',
              style: TextStyle(
                color: MyColor.white,
                fontFamily: 'Poppins',
                fontSize: unitFontSize,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
