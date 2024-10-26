import 'package:flutter/material.dart';
import 'build_day_content.dart';
import 'build_month_content.dart';
import 'build_week_content.dart';
import '../values/color.dart';

class HistoryPage extends StatelessWidget {
  final Map<double, double>? recordedData;
  const HistoryPage({super.key, this.recordedData});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalIndicatorPadding = screenWidth * 0.1;
    final dividerHeight = screenHeight * 0.001;

    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final textTabSize = scaleFactor * 23;

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: MyColor.white,
        appBar: AppBar(
          backgroundColor: MyColor.white,
          automaticallyImplyLeading: false,
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
        body: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 16),
          child: TabBarView(
            children: [
              // BuildDayContent(
              //   goal: 6,
              //    unit: 'L',
              //  waterConsumptionList: HomePage.quantityValues,
              //     hours: HomePage.hours,
              //
              //  ),
              BuildDayContent(
              ),
              BuildWeekContent(
              ),
              BuildMonthContent(
              ),
            ],
          ),
        ),
      ),
    );
  }
}
