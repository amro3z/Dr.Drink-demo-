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
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
  StreamController();
  static onTap(NotificationResponse notificationResponse) {
    log(notificationResponse.id!.toString());
    log(notificationResponse.payload!.toString());
    // streamController.add(notificationResponse);
    // Navigator.push(context, route);
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


  //showRepeatedNotification
  static void showRepeatedNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 2',
      'repeated notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',);
    NotificationDetails details = const NotificationDetails(
      android: android,
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'Repeated Notification',
      'body',
      RepeatInterval.hourly,
      details,
      payload: "Payload Data",
    );
  }

  static void scheduleWaterReminders() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'water_reminder_channel', // Channel ID
    'Water Reminder', // Channel Name
    channelDescription: 'Reminder to drink water', // Channel Description
    importance: Importance.high,
    priority: Priority.high,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  List<TimeOfDay> reminderTimes = [
    const TimeOfDay(hour: 18, minute: 40),
    const TimeOfDay(hour: 18, minute: 42),
    const TimeOfDay(hour: 18, minute: 44),
    const TimeOfDay(hour: 18, minute: 46),
  ];

  for (var time in reminderTimes) {
    final now = DateTime.now();
    final scheduledTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

    if (scheduledTime.isAfter(now)) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        reminderTimes.indexOf(time), // Unique ID for each notification
        'Water Reminder',
        'Time to drink water! Stay hydrated 💧',
        tzScheduledTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }
}


  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}