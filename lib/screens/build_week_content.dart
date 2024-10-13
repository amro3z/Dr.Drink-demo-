import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../values/color.dart';
import '../values/icons.dart';

class BuildWeekContent extends StatelessWidget {
  final double goal;
  final String unit;
  final Map<int, double> waterConsumptionMap;

  const BuildWeekContent({
    super.key,
    required this.goal,
    required this.unit,
    required this.waterConsumptionMap,
  });

  double get total {
    return waterConsumptionMap.values
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final textHeadSize = scaleFactor * 20;

    return Stack(
      children: [
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Row(
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
        ),
        Positioned(
          top: 90,
          left: 0,
          right: 0,
          child: Container(
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
                            '${total.toStringAsFixed(2)} $unit',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            '${goal.toStringAsFixed(2)} $unit',
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
        ),
      ],
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

    String text = value.toStringAsFixed(1);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  // Titles for the X Axis (Bottom)
  Widget getBottomTitles(double value, TitleMeta meta) {
    final style = TextStyle(
        color: MyColor.blue.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        fontSize: 16,
        fontFamily: 'Poppins');

    String text = waterConsumptionMap.containsKey(value.toInt())
        ? '${value.toInt()}' // Showing as hours (e.g., 8h, 12h)
        : '';
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  // Get Titles Data
  FlTitlesData getTitlesData(double goal) {
    double interval =
        goal / 4; // Divide the goal into four intervals to have five labels

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
              interval, // Set interval to evenly distribute from 0 to goal
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
    waterConsumptionMap.forEach((key, value) {
      barGroups.add(
        BarChartGroupData(
          x: key,
          barRods: [
            BarChartRodData(
              toY: value,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      );
    });
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
