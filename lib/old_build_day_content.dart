import 'package:dr_drink/screens/water_intake.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../componnent/record_card.dart';
import '../values/color.dart';
import '../values/icons.dart';

class BuildDayContent extends StatelessWidget {
  final double goal;
  final String unit;

  const BuildDayContent({
    super.key,
    required this.goal,
    required this.unit,
  });

  double get total {
    return WaterIntakeScreen.records
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final textHeadSize = scaleFactor * 20;

    return Container(
      color: MyColor.white,
      child: ListView(children: [
        Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyIcon.leftArrow,
                Text(
                  'Today',
                  style: TextStyle(
                    color: MyColor.blue,
                    fontFamily: 'Poppins',
                    fontSize: textHeadSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                MyIcon.rightArrow,
              ],
            ),
            SizedBox(height: 25,),

            Container(
              height: 450,
              decoration: ShapeDecoration(
                  color: MyColor.blue.withOpacity(0.04),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: MyColor.blue.withOpacity(0.4),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${total.toStringAsFixed(1)} $unit',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: MyColor.blue.withOpacity(0.9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Goal',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: MyColor.blue.withOpacity(0.4),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${goal.toStringAsFixed(1)} $unit',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: MyColor.blue.withOpacity(0.9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        barTouchData: barTouchData,
                        titlesData: getTitlesData(goal),
                        borderData: borderData,
                        barGroups: getBarGroups(),
                        gridData: getGridData(), // Add grid data to show dividers
                        alignment: BarChartAlignment.spaceAround,
                        maxY: goal, // Make sure max Y matches the goal
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Records',
                  style: TextStyle(
                    color: MyColor.blue,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: textHeadSize,
                  ),
                ),
                const SizedBox(height: 10),
                 Container(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: WaterIntakeScreen.records.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: RecordCard(
                          quantity: WaterIntakeScreen.records[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }

  // Configuration for Bar Touch Data
  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (BarChartGroupData group, int groupIndex,
              BarChartRodData rod, int rodIndex) {
            return BarTooltipItem(
              rod.toY.toStringAsFixed(1),
              TextStyle(
                color: MyColor.blue.withOpacity(0.2),
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
      );

  // Titles for the Y Axis (Left)
  Widget getLeftTitles(double value, TitleMeta meta, double goal) {
    final style = TextStyle(
      color: MyColor.blue.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 16,
      fontFamily: 'Poppins',
    );

    String text = value.toStringAsFixed(0);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  // Titles for the X Axis (Bottom)
  // Titles for the X Axis (Bottom)
  Widget getBottomTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: MyColor.blue.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 16,
      fontFamily: 'Poppins',
    );

    // Check if the index is valid within the records list
    if (value.toInt() < WaterIntakeScreen.records.length) {
      // Access the corresponding time label for the given index
      final timeLabel = WaterIntakeScreen.recordedTimesHour[value.toInt()]
          .toString(); // Ensure it's a string
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 4,
        child: Text(timeLabel, style: style), // Display the time as text
      );
    }

    return Container(); // Return an empty container if no valid time is found
  }

  // Get Titles Data
  FlTitlesData getTitlesData(double goal) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 50,
          getTitlesWidget: getBottomTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 50, // Adjusted to align y-axis titles
          interval:
              goal / 4, // Set interval to evenly distribute from 0 to goal
          getTitlesWidget: (value, meta) => getLeftTitles(value, meta, goal),
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  // Configure Border Data
  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          left: BorderSide(
            color: MyColor.blue.withOpacity(0.2), // Set your desired color
            width: 1, // Set the border width
          ),
          bottom: BorderSide(
            color: MyColor.blue.withOpacity(0.2), // Set your desired color
            width: 1, // Set the border width
          ),
          right: BorderSide.none, // No border on the right
          top: BorderSide.none, // No border on the top
        ),
      );

  // Configure Gradient for Bars
  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Colors.white70.withOpacity(0.5),
          MyColor.white,
          MyColor.white,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  // Generate dynamic Bar Groups Data
  List<BarChartGroupData> getBarGroups() {
    List<BarChartGroupData> barGroups = [];

    // Loop through the records to create BarChartGroupData
    for (int i = 0; i < WaterIntakeScreen.records.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i, // Use the index of the record as the X value
          barRods: [
            BarChartRodData(
              toY: WaterIntakeScreen.records[i], // Set Y value to the record
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: [0], // Optional: Show tooltips for this bar
        ),
      );
    }

    return barGroups;
  }

  // Grid Data to show dividers for X-Axis and Y-Axis
  FlGridData getGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: true, // Enable vertical dividers
      verticalInterval: 4, // Interval for x-axis grid lines
      drawHorizontalLine: true, // Enable horizontal dividers
      horizontalInterval: goal / 4, // Interval for y-axis grid lines
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: MyColor.white,
          strokeWidth: 1,
        );
      },
    );
  }
}
