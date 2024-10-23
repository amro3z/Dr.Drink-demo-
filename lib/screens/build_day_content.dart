import 'package:dr_drink/logic/user.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../component/record_card.dart';
import '../values/color.dart';
import '../values/icons.dart';

class BuildDayContent extends StatefulWidget {
  @override
  _WaterTrackerScreenState createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<BuildDayContent> {
  final MyUser _user = MyUser.instance;
  // final History _history = History.instance;
  String? unit; // Default unit
  int goal = 2000; // Daily water goal in ml

  @override
  void initState() {
    super.initState();
    goal = _user.tracker.totalWaterGoal!;
    unit = _user.profile.unit ?? 'ml';
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
              _buildHeader(textHeadSize),
              SizedBox(height: 25),
              _buildChartContainer(textHeadSize),
              SizedBox(height: 10),
              _buildRecordsSection(textHeadSize),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double textHeadSize) {
    return Row(
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
    );
  }

  Widget _buildChartContainer(double textHeadSize) {
    return Container(
      height: 450,
      decoration: ShapeDecoration(
        color: MyColor.blue.withOpacity(0.04),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsRow(textHeadSize),
            SizedBox(height: 10),
            _buildBarChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(double textHeadSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatColumn('Total/Goal', '${_getTotalConsumption()}/${_getTotalGoal()} $unit', textHeadSize),
          _buildStatColumn('Average', '${_getAveragePerHour()} $unit', textHeadSize),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String title, String value, double textHeadSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: MyColor.blue,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: textHeadSize * 0.8,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: MyColor.blue,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: textHeadSize * 0.7,
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    return Expanded(
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
            verticalInterval: 1,
            getDrawingVerticalLine: (value) => FlLine(
              color: Colors.transparent,
              strokeWidth: 0,
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
                '',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Poppins'),
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
                '',
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
    );
  }

  Widget _buildRecordsSection(double textHeadSize) {
    return Column(
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
            itemCount: _user.history.records.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: RecordCard(
                  quantity: _user.history.records[index],
                  time: _user.history.recordedTimes[index],
                  unit: unit!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < 24; i++) {
      double value = unit == 'ml'
          ? _user.history.hourlyConsumption[i].toDouble()
          : _user.history.hourlyConsumption[i] / 1000;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value,
              width: 10,
              gradient: LinearGradient(
                colors: [
                  Colors.blue, // Top color
                  Colors.white.withOpacity(0.5), // Bottom color
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }
    return barGroups;
  }

  String _getTotalConsumption() {
    int total = _user.history.hourlyConsumption.fold(0, (sum, value) => sum + value);
    double convertedTotal = unit == 'ml' ? total.toDouble() : total / 1000;
    return unit == 'ml' ? total.toString() : convertedTotal.toStringAsFixed(1);
  }

  String _getTotalGoal() {
    double convertedGoal = unit == 'ml' ? goal.toDouble() : goal / 1000;
    return unit == 'ml' ? goal.toString() : convertedGoal.toStringAsFixed(1);
  }

  String _getAveragePerHour() {
    int total = _user.history.hourlyConsumption.fold(0, (sum, value) => sum + value);
    int hoursWithConsumption =
        _user.history.hourlyConsumption.where((value) => value > 0).length;

    if (hoursWithConsumption == 0) return '0';

    double average = total / hoursWithConsumption;
    double convertedAverage = unit == 'ml' ? average : average / 1000;

    return unit == 'ml'
        ? convertedAverage.toStringAsFixed(0)
        : convertedAverage.toStringAsFixed(1);
  }

  double _getMaxYValue() {
    int maxConsumed = _user.history.hourlyConsumption.fold(0, (a, b) => a > b ? a : b);
    int maxGoal = goal;
    double maxY = maxConsumed > maxGoal ? maxConsumed.toDouble() : maxGoal.toDouble();
    return unit == 'ml' ? maxY : maxY / 1000;
  }
}
