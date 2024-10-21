import 'package:dr_drink/screens/history_screen.dart';
import 'package:dr_drink/screens/insights_screen.dart';
import 'package:dr_drink/screens/profile_screen.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../logic/notifications.dart';
import '../screens/water_tracker_page.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});
  @override
  State<CustomNavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<CustomNavigationBar> {
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

    // _loadUserFromSharedPrefs();
    _initNotifications();
  }
  //
  // // load user from shared prefs
  // Future<void> _loadUserFromSharedPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   MyUser user = MyUser.fromMap(json.decode(prefs.getString('user')!));
  //   log("user loaded from shared prefs");
  //   log(user.toString());
  // }

  void _initNotifications() async {
    await requestPermissions();
    await Permission.ignoreBatteryOptimizations.request();
    LocalNotificationService.showRepeatedNotification();
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
