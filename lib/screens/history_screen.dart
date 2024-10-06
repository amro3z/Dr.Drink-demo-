import 'package:dr_drink/values/icons.dart';
import 'package:flutter/material.dart';
import 'package:dr_drink/values/color.dart';
import '../componnent/navigation_bar.dart';
import 'buildDayContent.dart';
import 'buildMonthContent.dart';
import 'buildWeekContent.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalIndicatorPadding = screenWidth * 0.1;
    final dividerHeight = screenHeight * 0.001;

    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final textTabSize = scaleFactor * 23;
    // final textHeadSize = scaleFactor * 20;
    // final horizontalPadding = (16/screenWidth) *100;

    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              tabs: [
                Tab(
                  child: Text(
                    'Day',
                    style: TextStyle(
                        color: MyColor.blue,
                        fontFamily: 'Poppins',
                        fontSize: textTabSize,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Tab(
                  child: Text(
                    'Week',
                    style: TextStyle(
                        color: MyColor.blue,
                        fontFamily: 'Poppins',
                        fontSize: textTabSize,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Tab(
                  child: Text(
                    'Month',
                    style: TextStyle(
                        color: MyColor.blue,
                        fontFamily: 'Poppins',
                        fontSize: textTabSize,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
              indicatorColor: MyColor.blue,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding:
              EdgeInsets.symmetric(horizontal: horizontalIndicatorPadding),
              dividerColor: MyColor.blue.withOpacity(0.2),
              dividerHeight: dividerHeight,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TabBarView(
                    children: [
                      BuildDayContent(
                        goal: 2.5,
                        unit: 'L',
                        waterConsumptionMap: {
                          8: 0.5,
                          12: 0.8,
                          16: 0.5,
                          20: 0.5,
                          22: 0.2,
                          23: 0.2,
                          24: 0.2,
                        },
                      ),
                      BuildWeekContent(),
                      BuildMonthContent(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40, right: 16, left: 16),
                child: BottomBar(
                  homeOpacity: 0.5,
                  historyOpacity: 1,
                  insightsOpacity: 0.5,
                  avatarOpacity: 0.5,
                ),
              ),
            ],
          ),
        ));
  }
}