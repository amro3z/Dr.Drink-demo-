import 'package:dr_drink/screens/water_intake.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../componnent/record_card.dart';
import '../logic/user.dart';
import '../values/color.dart';
import '../values/icons.dart';

class BuildWeekContent extends StatefulWidget {
  @override
  _WeekTrackerScreenState createState() => _WeekTrackerScreenState();
}

class _WeekTrackerScreenState extends State<BuildWeekContent> {
  final MyUser _user = MyUser.instance;
  String? unit; // Default unit
  int maxYaxis = 4000; // amount of water in ml
  int avg = 2000; // Weekly average consumption in ml per day

  // Initialize a list of size 7 for weekly consumption (Sunday to Saturday)
  List<int> weeklyConsumption = List.filled(7, 0);

  @override
  void initState() {
    super.initState();
    // Populate the weeklyConsumption list with sample data (starting from Sunday)
    weeklyConsumption[0] = 1800; // Sunday
    weeklyConsumption[1] = 2000; // Monday
    weeklyConsumption[2] = 1600; // Tuesday
    weeklyConsumption[3] = 2200; // Wednesday
    weeklyConsumption[4] = 1500; // Thursday
    weeklyConsumption[5] = 1700; // Friday
    weeklyConsumption[6] = 2200; // Saturday

    unit = _user.unit??'ml';
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
                                  switch (value.toInt()) {
                                    case 0:
                                      return const Text('Sun',
                                          style: TextStyle(fontSize: 12));
                                    case 1:
                                      return const Text('Mon',
                                          style: TextStyle(fontSize: 12));
                                    case 2:
                                      return const Text('Tue',
                                          style: TextStyle(fontSize: 12));
                                    case 3:
                                      return const Text('Wed',
                                          style: TextStyle(fontSize: 12));
                                    case 4:
                                      return const Text('Thu',
                                          style: TextStyle(fontSize: 12));
                                    case 5:
                                      return const Text('Fri',
                                          style: TextStyle(fontSize: 12));
                                    case 6:
                                      return const Text('Sat',
                                          style: TextStyle(fontSize: 12));
                                    default:
                                      return SizedBox();
                                  }
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
    for (int i = 0; i < 7; i++) {
      double value = unit == 'ml'
          ? weeklyConsumption[i].toDouble()
          : weeklyConsumption[i] / 1000;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value,
              width: 16,
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
    int total = weeklyConsumption.fold(0, (sum, value) => sum + value);
    double convertedTotal = unit == 'ml' ? total.toDouble() : total / 1000;
    return unit == 'ml' ? total.toString() : convertedTotal.toStringAsFixed(1);
  }

  String _getAverageConsumption() {
    int total = weeklyConsumption.fold(0, (sum, value) => sum + value);
    int count = weeklyConsumption.where((element) => element > 0).length;
    double average = total / count;
    double convertedAverage = unit == 'ml' ? average : average / 1000;
    return unit == 'ml'
        ? average.toStringAsFixed(0)
        : convertedAverage.toStringAsFixed(1);
  }

  double _getMaxYValue() {
    int maxConsumed = weeklyConsumption.fold(0, (a, b) => a > b ? a : b);
    int maxGoal = maxYaxis;

    double maxY =
    maxConsumed > maxGoal ? maxConsumed.toDouble() : maxGoal.toDouble();
    return unit == 'ml' ? maxY : maxY / 1000;
  }
}
