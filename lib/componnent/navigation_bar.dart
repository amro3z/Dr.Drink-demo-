import 'package:dr_drink/screens/home_screen.dart';
import 'package:dr_drink/screens/history_screen.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/insights_screen.dart';
import '../screens/profile_screen.dart';

class BottomBar extends StatefulWidget {
  final double homeOpacity;
  final double historyOpacity;
  final double insightsOpacity;
  final double avatarOpacity;
  BottomBar(
      {required this.homeOpacity,
      required this.historyOpacity,
      required this.insightsOpacity,
      required this.avatarOpacity});
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    double _homeOpacity = widget.homeOpacity;
    double _historyOpacity = widget.historyOpacity;
    double _insightsOpacity = widget.insightsOpacity;
    double _avatarOpacity = widget.avatarOpacity;

    return Positioned(
      bottom: 40,
      left: 16,
      right: 16,
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
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Opacity(
                  opacity: _homeOpacity,
                  child: Image.asset('assets/icons/raindrop.png'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryPage()),
                  );
                },
                child: Opacity(
                  opacity: _historyOpacity,
                  child: Image.asset('assets/icons/clock.png'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => InsightsPage()),
                  );
                },
                child: Opacity(
                  opacity: _insightsOpacity,
                  child: Image.asset('assets/icons/insights.png'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: Opacity(
                  opacity: _avatarOpacity,
                  child: Image.asset('assets/icons/avatar.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
