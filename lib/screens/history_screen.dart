import 'package:dr_drink/values/icons.dart';
import 'package:flutter/material.dart';
import 'package:dr_drink/values/color.dart';

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
    final textTabSize = screenWidth * 0.015;
    final textHeadSize = screenWidth * 0.015;

    final textPostionVertically = screenHeight * 0.1;
    final textPostionHorizontally = screenWidth / 2;

    return DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
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
          body: TabBarView(children: [
            Stack(
              children: [
                Row(
                  children: [
                    MyIcon.leftArrow,
                    Text(
                      'Today',
                      style: TextStyle(
                          color: MyColor.blue,
                          fontFamily: 'Poppins',
                          fontSize: textHeadSize,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )
              ],
            )
          ]),
        ));
  }
}
