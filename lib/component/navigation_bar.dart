import 'package:dr_drink/screens/history_screen.dart';
import 'package:dr_drink/screens/insights_screen.dart';
import 'package:dr_drink/screens/profile_screen.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../logic/notifications.dart';
import '../logic/user.dart';
import '../screens/water_tracker_page.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});
  @override
  State<CustomNavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<CustomNavigationBar> {
  final MyUser _user = MyUser.instance;
  int currentPageIndex = 0;
  final List<Widget> _pages = [
    const WaterTrackerPage(),
    const HistoryPage(),
    const InsightsPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();

    _initNotifications();
  }

  void _initNotifications() async {
    await requestPermissions();
    await Permission.ignoreBatteryOptimizations.request();
    LocalNotificationService.setNotificationSound(_user.profile.notificationSound);
    LocalNotificationService.generateSchedule(_user.data.wakeUpTime!, _user.data.bedTime!);
    // LocalNotificationService.showRepeatedNotification();
    LocalNotificationService.showHourlyNotificationsBetweenTimes();
  }

  Future<void> requestPermissions() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentPageIndex == 3 ? MyColor.blue : MyColor.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
        child: Container(
          height: 65,
          decoration: BoxDecoration(
              color: MyColor.blue,
              borderRadius: BorderRadius.circular(45),
              boxShadow: [
                BoxShadow(
                  color: MyColor.blue.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]),
          child: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            indicatorColor: Colors.transparent,
            indicatorShape: const CircleBorder(),


            backgroundColor: Colors.transparent,
            elevation: 0,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            destinations: <Widget>[
              NavigationDestination(
                  icon: Opacity(
                      opacity: currentPageIndex == 0 ? 1.0 : 0.5,
                      child: Image.asset('assets/icons/raindrop.png', width: 24, height: 24,)),
                  label: ''),
              NavigationDestination(
                icon: Opacity(
                    opacity: currentPageIndex == 1 ? 1.0 : 0.5,
                    child: Image.asset('assets/icons/clock.png', width: 24, height: 24,)),
                label: '',
              ),
              NavigationDestination(
                  icon: Opacity(
                      opacity: currentPageIndex == 2 ? 1.0 : 0.5,
                      child: Image.asset('assets/icons/insights.png', width: 24, height: 24,)),
                  label: ''),
              NavigationDestination(
                  icon: Opacity(
                      opacity: currentPageIndex == 3 ? 1.0 : 0.5,
                      child: Image.asset('assets/icons/avatar.png', width: 24, height: 24,)),
                  label: ''),
            ],
          ),
        ),
      ),
      body: _pages[currentPageIndex],
    );
  }
}

/*
static void showHourlyNotificationsBetweenTimes(String wakeUpTime, String bedTime) async {
    // Ensure correct timezone setup
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    // Get the current date to calculate notifications for today
    final now = tz.TZDateTime.now(tz.local);

    // Create tzDateTimes for wake-up and bedtime today
    final wakeUp = _stringToTimeOfDay(wakeUpTime, now);
    final bed = _stringToTimeOfDay(bedTime, now);

    // If wake-up or bedtime is in the past, adjust to tomorrow
    final start = wakeUp.isBefore(now) ? now.add(const Duration(minutes: 15)) : wakeUp;
    final end = bed.isBefore(wakeUp) ? bed.add(const Duration(days: 1)) : bed;

    log(start.toString());
    log(end.toString());

    // Loop through each hour between wake-up and bedtime
    var scheduleTime = start;
    int notificationId = 100; // Start with a unique notification ID

    while (scheduleTime.isBefore(end)) {
      log(notificationSound);
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
        scheduleTime,
        details,
        payload: 'hourly_reminder',
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );

      // Move to the next hour
      scheduleTime = scheduleTime.add(const Duration(minutes: 15));
    }
    log('Notifications scheduled successfully!');
  }

  static _stringToTimeOfDay(String time, TZDateTime now) {
    var hoursAndMinutes = time.split(' ');
    var hours = hoursAndMinutes[0].split(':');
    var wakeHour = int.parse(hours[0]);
    var wakeMinute = int.parse(hours[1]);

    return tz.TZDateTime(tz.local, now.year, now.month, now.day,
        wakeHour, wakeMinute);
  }
  */