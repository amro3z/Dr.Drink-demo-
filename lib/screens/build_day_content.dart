import 'package:dr_drink/logic/user.dart';
import 'package:dr_drink/screens/water_intake.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../componnent/record_card.dart';
import '../logic/history.dart';
import '../values/color.dart';
import '../values/icons.dart';

class BuildDayContent extends StatefulWidget {
  @override
  _WaterTrackerScreenState createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<BuildDayContent> {
  final MyUser _user = MyUser.instance;
  final History _history = History.instance;
  String? unit; // Default unit
  int goal = 2000; // Daily water goal in ml

  // Initialize a list of size 24 for hourly consumption
  // List<int> hourlyConsumption = List.filled(24, 0);

  @override
  void initState() {
    super.initState();
    // Populate the hourlyConsumption list with sample data
    // hourlyConsumption[0] = 100;
    // hourlyConsumption[1] = 400;
    // hourlyConsumption[2] = 300;
    // hourlyConsumption[3] = 500;
    // hourlyConsumption[4] = 200;
    // hourlyConsumption[5] = 700;
    // hourlyConsumption[6] = 800;
    // hourlyConsumption[7] = 800;
    // hourlyConsumption[8] = 900;
    // hourlyConsumption[9] = 1000;
    // hourlyConsumption[10] = 500;
    // hourlyConsumption[11] = 600;
    // hourlyConsumption[12] = 600;
    // hourlyConsumption[13] = 700;
    // hourlyConsumption[14] = 800;
    // hourlyConsumption[15] = 900;
    // hourlyConsumption[16] = 400;
    // hourlyConsumption[17] = 500;
    // hourlyConsumption[18] = 600;
    // hourlyConsumption[19] = 700;
    // hourlyConsumption[20] = 900;
    // hourlyConsumption[21] = 1000;
    // hourlyConsumption[22] = 200;
    // hourlyConsumption[23] = 300;

    goal = _user.tracker.totalWaterGoal!;
    unit = _user.unit ?? 'ml';
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final textHeadSize = scaleFactor * 20;

    return Container(
      color: MyColor.white,
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 10),
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
              SizedBox(height: 25),
              Container(
                height: 450,
                decoration: ShapeDecoration(
                  color: const Color(0xFF2A6CE6).withOpacity(0.04),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Total, Goal, and Average row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total/Goal',
                                  style: TextStyle(
                                    color: MyColor.blue,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: textHeadSize * 0.8,
                                  ),
                                ),
                                Text(
                                  '${_getTotalConsumption()}/${_getTotalGoal()} $unit',
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
                                  'Average/hour',
                                  style: TextStyle(
                                    color: MyColor.blue,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: textHeadSize * 0.8,
                                  ),
                                ),
                                Text(
                                  '${_getAveragePerHour()} $unit',
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
                      SizedBox(height: 10),
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
                                sideTitles:
                                SideTitles(showTitles: false), // Hide top X-axis
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles:
                                SideTitles(showTitles: false), // Hide right Y-axis
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
                                  'Hour',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: (value, _) {
                                    if (value % 4 == 0 || value == 0 || value == 23) {
                                      return Text(
                                        value.toInt().toString(),
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
              SizedBox(height: 10),
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
                      itemCount: _history.records.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: RecordCard(
                            quantity: _history.records[index],
                            time: _history.recordedTimes[index],
                            unit: unit!,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < 24; i++) {
      double value = unit == 'ml'
          ? _history.hourlyConsumption[i].toDouble()
          : _history.hourlyConsumption[i] / 1000;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value,
              width: 10,
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
    int total = _history.hourlyConsumption.fold(0, (sum, value) => sum + value);
    double convertedTotal = unit == 'ml' ? total.toDouble() : total / 1000;
    return unit == 'ml' ? total.toString() : convertedTotal.toStringAsFixed(1);
  }

  String _getTotalGoal() {
    double convertedGoal = unit == 'ml' ? goal.toDouble() : goal / 1000;
    return unit == 'ml' ? goal.toString() : convertedGoal.toStringAsFixed(1);
  }

  String _getAveragePerHour() {
    int total = _history.hourlyConsumption.fold(0, (sum, value) => sum + value);
    int hoursWithConsumption =
        _history.hourlyConsumption.where((value) => value > 0).length;

    if (hoursWithConsumption == 0) return '0';

    double average = total / hoursWithConsumption;
    double convertedAverage = unit == 'ml' ? average : average / 1000;

    return unit == 'ml'
        ? convertedAverage.toStringAsFixed(0)
        : convertedAverage.toStringAsFixed(1);
  }

  double _getMaxYValue() {
    int maxConsumed = _history.hourlyConsumption.fold(0, (a, b) => a > b ? a : b);
    int maxGoal = goal;
    double maxY = maxConsumed > maxGoal ? maxConsumed.toDouble() : maxGoal.toDouble();
    return unit == 'ml' ? maxY : maxY / 1000;
  }
}
