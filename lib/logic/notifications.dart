import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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


  static generateSchedule(TimeOfDay wakeUpTime, TimeOfDay bedTime, TimeOfDay interval)
  {
    _notificationTimes = [];
    cancelAllNotifications();

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    // Get the current time
    final now = tz.TZDateTime.now(tz.local);

    var wakeUp = tz.TZDateTime(tz.local, now.year, now.month, now.day, wakeUpTime.hour, wakeUpTime.minute);
    var bed = tz.TZDateTime(tz.local, now.year, now.month, now.day, bedTime.hour, bedTime.minute);

    // If bedtime is before wake-up (spans two days), adjust bedtime
    if (bed.isBefore(wakeUp)) {
      bed = bed.add(const Duration(days: 1));
    }

    var currentTime = wakeUp;
    while (true) {
      currentTime = currentTime.add(Duration(hours: interval.hour, minutes: interval.minute));
      if (currentTime.isAfter(bed) || currentTime.isAtSameMomentAs(bed)) {
        break;
      }
      _notificationTimes.add(currentTime);
    }

    log(_notificationTimes.toString());
  }

  static void schedule() async {
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
    log(_notificationTimes.toString());
  }



  static void cancelAllNotifications() async {
    log('Cancelling all notifications');
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
