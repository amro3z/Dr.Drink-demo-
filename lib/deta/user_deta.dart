import 'package:dr_drink/widgets/ageWidget.dart';
import 'package:dr_drink/widgets/genderWidget.dart';
import 'package:dr_drink/widgets/mealWidget.dart';
import 'package:dr_drink/widgets/sleepWidget.dart';
import 'package:dr_drink/widgets/wakeWidget.dart';
import 'package:dr_drink/widgets/weightWidget.dart';
import 'package:flutter/material.dart';

class UserDeta {
  static String gender = GenderWidget.gender; // افتراضياً
  static int weight = Weightwidget.selectedWeight; // افتراضياً
  static int age = Agewidget.selectedAge; // افتراضياً

  // استخدام static لتخزين الأوقات
  static TimeOfDay wakesup = _getTimeOfDay(Wakewidget.selectedHour,
      Wakewidget.selectedMinute, Wakewidget.selectedPeriod);
  static TimeOfDay sleep = _getTimeOfDay(Sleepwidget.selectedHour,
      Sleepwidget.selectedMinute, Sleepwidget.selectedPeriod);
  static TimeOfDay breakfastTime = _getTimeOfDay(MealWidget.breakfastHour,
      MealWidget.breakfastMinute, MealWidget.breakfastPeriod);
  static TimeOfDay lunchTime = _getTimeOfDay(
      MealWidget.lunchHour, MealWidget.lunchMinute, MealWidget.lunchPeriod);
  static TimeOfDay dinnerTime = _getTimeOfDay(
      MealWidget.dinnerHour, MealWidget.dinnerMinute, MealWidget.dinnerPeriod);

  // دالة لتحويل الساعة والدقيقة مع الفترة (AM/PM) إلى TimeOfDay
  static TimeOfDay _getTimeOfDay(int hour, int minute, String period) {
    // تحويل الصيغة 12 ساعة إلى 24 ساعة بناءً على الفترة
    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0; // تحويل 12 AM إلى منتصف الليل (00:00)
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  // دالة لتحويل TimeOfDay إلى String منسق (لتسهيل الطباعة أو العرض)
  static String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0
        ? 12
        : time.hourOfPeriod; // تحويل 0 إلى 12 لـ AM/PM
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
  }
}
