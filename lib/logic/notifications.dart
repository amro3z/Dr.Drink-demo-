import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class LocalNotificationService {
  static String notificationSound = 'water_pouring';
  static List<tz.TZDateTime> _notificationTimes = [];
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController = StreamController();

  static onTap(NotificationResponse notificationResponse) {
    log(notificationResponse.id!.toString());

    streamController.add(notificationResponse);
    // Navigator.push(context, route);
  }

  static void setNotificationSound(String sound) {
    notificationSound = sound;
  }

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static void showHourlyNotificationsBetweenTimes() async {
    // Ensure correct timezone setup
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    final now = tz.TZDateTime.now(tz.local); // Get current time
    int notificationId = 100; // Unique notification ID

    // Iterate over the generated notification times
    for (var i = 0; i < _notificationTimes.length; i++) {
      var time = _notificationTimes[i];
      // Adjust if the notification time is in the past
      if (time.isBefore(now)) {
        time = time.add(const Duration(days: 1));
        _notificationTimes[i] = time; // Update the time in the list
      }

      // log(notificationSound);
      NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
          'sound: $notificationSound',
          'repeated notification',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          sound: RawResourceAndroidNotificationSound(notificationSound),
        ),
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId++, // Unique ID for each notification as in zoneSchedule not allowed to have same id
        'Water Reminder',
        'Time to drink water! Stay hydrated 💧',
        time,
        details,
        payload: 'hourly_reminder',
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
    log('Notifications scheduled successfully!');
  }

  static generateSchedule(String wakeUpTime, String bedTime)
  {
    // Get the current time
    final now = tz.TZDateTime.now(tz.local);

    // Create wake-up and bedtime objects for today
    var wakeUp = _stringToTimeOfDay(wakeUpTime, now);
    var bed = _stringToTimeOfDay(bedTime, now);

    // If bedtime is before wake-up (spans two days), adjust bedtime
    if (bed.isBefore(wakeUp)) {
      bed = bed.add(const Duration(days: 1));
    }

    var currentTime = wakeUp;
    while (currentTime.isBefore(bed)) {
      _notificationTimes.add(currentTime);
      currentTime = currentTime.add(const Duration(minutes: 15));
    }

    log(_notificationTimes.toString());
  }

  static _stringToTimeOfDay(String time, var now) {
    // 06:00 AM
    var timeFormated = time.split(' ');
    var period = timeFormated[1];
    var hoursAndMinutes = timeFormated[0].split(':');
    var wakeHour = period == 'AM' ? int.parse(hoursAndMinutes[0]) : int.parse(hoursAndMinutes[0]) + 12;
    var wakeMinute = int.parse(hoursAndMinutes[1]);

    return tz.TZDateTime(tz.local, now.year, now.month, now.day,
        wakeHour, wakeMinute);
  }


  static void cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
