import 'package:dr_drink/componnent/record_card.dart';
import 'package:dr_drink/screens/history_screen.dart';
import 'package:dr_drink/screens/home_screen.dart';
import 'package:dr_drink/screens/insights_screen.dart';
import 'package:dr_drink/screens/profile_screen.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  @override
  State<CustomNavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<CustomNavigationBar> {
  int currentPageIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    InsightsPage(),
    RecordCard(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 40),
        child: Container(
          height: 75,
          decoration: BoxDecoration(
              color: MyColor.blue,
              borderRadius: BorderRadius.circular(45),
              boxShadow: [
                BoxShadow(
                  color: MyColor.blue.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 2),
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
                      child: Image.asset('assets/icons/raindrop.png')),
                  label: ''),
              NavigationDestination(
                icon: Opacity(
                    opacity: currentPageIndex == 1 ? 1.0 : 0.5,
                    child: Image.asset('assets/icons/clock.png')),
                label: '',
              ),
              NavigationDestination(
                  icon: Opacity(
                      opacity: currentPageIndex == 2 ? 1.0 : 0.5,
                      child: Image.asset('assets/icons/insights.png')),
                  label: ''),
              NavigationDestination(
                  icon: Opacity(
                      opacity: currentPageIndex == 3 ? 1.0 : 0.5,
                      child: Image.asset('assets/icons/avatar.png')),
                  label: ''),
            ],
          ),
        ),
      ),
      body: _pages[currentPageIndex],
    );
  }
}
