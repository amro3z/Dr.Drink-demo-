import 'package:dr_drink/screens/water_intake.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../componnent/record_card.dart';
import '../logic/user.dart';
import '../values/color.dart';
import '../values/icons.dart';

class BuildMonthContent extends StatefulWidget {
  @override
  _MonthTrackerScreenState createState() => _MonthTrackerScreenState();
}

class _MonthTrackerScreenState extends State<BuildMonthContent> {
  final MyUser _user = MyUser.instance;
  String? unit; // Default unit
  int goal = 10000; // Daily water goal in ml

  // Initialize a list of size 31 for monthly consumption (1 to 31)
  List<int> monthlyConsumption = List.filled(31, 0);

  @override
  void initState() {
    super.initState();
    // Populate the monthlyConsumption list with sample data for each day
    monthlyConsumption[0] = 2000; // Day 1
    monthlyConsumption[1] = 1800; // Day 2
    monthlyConsumption[2] = 2200; // Day 3
    monthlyConsumption[3] = 1600; // Day 4
    monthlyConsumption[4] = 2000; // Day 5
    monthlyConsumption[5] = 2400; // Day 6
    monthlyConsumption[6] = 1800; // Day 7
    monthlyConsumption[10] = 2500; // Day 11
    monthlyConsumption[15] = 3000; // Day 16
    monthlyConsumption[20] = 2100; // Day 21
    monthlyConsumption[25] = 2600; // Day 26
    monthlyConsumption[30] = 2800; // Day 31

    unit = _user.unit ?? 'ml';
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyIcon.leftArrow,
                Text(
                  'This Week',
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
            SizedBox(height: 25),
            Container(
              height: 450,
              decoration: ShapeDecoration(
                color: const Color(0xFF2A6CE6).withOpacity(0.04),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Total and Average row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  color: MyColor.blue,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: textHeadSize * 0.8,
                                ),
                              ),
                              Text(
                                '${_getTotalConsumption()} $unit',
                                style: TextStyle(
                                  color: MyColor.blue,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: textHeadSize * 0.7,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Average/day',
                                style: TextStyle(
                                  color: MyColor.blue,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: textHeadSize * 0.8,
                                ),
                              ),
                              Text(
                                '${_getAverageConsumption()} $unit',
                                style: TextStyle(
                                  color: MyColor.blue,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: textHeadSize * 0.7,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10), // Add some space
                    // BarChart
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceBetween,
                          maxY: _getMaxYValue(),
                          barGroups: _buildBarGroups(),
                          gridData: FlGridData(
                            show: true,
                            horizontalInterval: (_getMaxYValue() / 4),
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: Colors.grey.withOpacity(0.5),
                              strokeWidth: 1,
                            ),
                          ),
                          titlesData: FlTitlesData(
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              axisNameWidget: Text(
                                unit!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                interval: (_getMaxYValue() / 4),
                                getTitlesWidget: (value, _) {
                                  return Text(
                                    unit == 'ml'
                                        ? value.toInt().toString()
                                        : value.toStringAsFixed(1),
                                    style: const TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              axisNameWidget: const Text(
                                'Day',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (value, _) {
                                  // Display only key days for better readability (1, 5, 10, etc.)
                                  if (value == 0 || value == 4 || value == 9 ||
                                      value == 14 || value == 19 || value == 24 ||
                                      value == 30) {
                                    return Text(
                                      (value + 1)
                                          .toInt()
                                          .toString(), // Convert index to day number
                                      style: TextStyle(fontSize: 12),
                                    );
                                  }
                                  return SizedBox();
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < 31; i++) {
      double value = unit == 'ml'
          ? monthlyConsumption[i].toDouble()
          : monthlyConsumption[i] / 1000;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value,
              width: 5,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }
    return barGroups;
  }

  String _getTotalConsumption() {
    int total = monthlyConsumption.fold(0, (sum, value) => sum + value);
    double convertedTotal = unit == 'ml' ? total.toDouble() : total / 1000;
    return unit == 'ml' ? total.toString() : convertedTotal.toStringAsFixed(1);
  }

  String _getAverageConsumption() {
    int total = monthlyConsumption.fold(0, (sum, value) => sum + value);
    int count = monthlyConsumption.where((element) => element > 0).length;
    double average = total / count; // Assuming all days of the month
    double convertedAverage = unit == 'ml' ? average : average / 1000;
    return unit == 'ml'
        ? average.toStringAsFixed(0)
        : convertedAverage.toStringAsFixed(1);
  }

  double _getMaxYValue() {
    int maxConsumed = monthlyConsumption.fold(0, (a, b) => a > b ? a : b);
    int maxGoal = goal;

    double maxY =
        maxConsumed > maxGoal ? maxConsumed.toDouble() : maxGoal.toDouble();
    return unit == 'ml' ? maxY : maxY / 1000;
  }
}
