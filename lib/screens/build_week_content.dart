import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../logic/user.dart';
import '../values/color.dart';
import '../values/icons.dart';
import '../logic/history.dart';

class BuildWeekContent extends StatefulWidget {
  @override
  _WeekTrackerScreenState createState() => _WeekTrackerScreenState();
}

class _WeekTrackerScreenState extends State<BuildWeekContent> {
  final MyUser _user = MyUser.instance;
  // final History _history = History.instance;
  String? unit; // Default unit
  int maxYaxis = 4000; // Amount of water in ml

  @override
  void initState() {
    super.initState();
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
              const SizedBox(height: 25),
              _buildChartContainer(textHeadSize),
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
    );
  }

  Widget _buildChartContainer(double textHeadSize) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: MyColor.blue.withOpacity(0.04),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsRow(textHeadSize),
            const SizedBox(height: 20), // Add some space
            Expanded(child: _buildBarChart()),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(double textHeadSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatColumn('Total', '${_getTotalConsumption()} $unit', textHeadSize),
        _buildStatColumn('Average', '${_getAverageConsumption()} $unit', textHeadSize),
      ],
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
    return BarChart(
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
            axisNameWidget: const Text(
              "",
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
              '',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 12),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, _) {
                switch (value.toInt()) {
                  case 0:
                    return const Text('S', style: TextStyle(fontSize: 12));
                  case 1:
                    return const Text('M', style: TextStyle(fontSize: 12));
                  case 2:
                    return const Text('T', style: TextStyle(fontSize: 12));
                  case 3:
                    return const Text('W', style: TextStyle(fontSize: 12));
                  case 4:
                    return const Text('T', style: TextStyle(fontSize: 12));
                  case 5:
                    return const Text('F', style: TextStyle(fontSize: 12));
                  case 6:
                    return const Text('S', style: TextStyle(fontSize: 12));
                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < 7; i++) {
      double value = unit == 'ml'
          ? _user.history.weeklyConsumption[i].toDouble()
          : _user.history.weeklyConsumption[i] / 1000;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value,
              width: 16,
              gradient: LinearGradient(
                colors: [
                  Colors.blue, // Top color
                  Colors.blue.withOpacity(0.5), // Bottom color
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
    int total = _user.history.weeklyConsumption.fold(0, (sum, value) => sum + value);
    double convertedTotal = unit == 'ml' ? total.toDouble() : total / 1000;
    return unit == 'ml' ? total.toString() : convertedTotal.toStringAsFixed(1);
  }

  String _getAverageConsumption() {
    int total = _user.history.weeklyConsumption.fold(0, (sum, value) => sum + value);
    int count = _user.history.weeklyConsumption.where((element) => element > 0).length;

    if (count == 0) {
      return '0';
    }

    double average = total / count;
    double convertedAverage = unit == 'ml' ? average : average / 1000;
    return unit == 'ml'
        ? average.toStringAsFixed(0)
        : convertedAverage.toStringAsFixed(1);
  }

  double _getMaxYValue() {
    int maxConsumed = _user.history.weeklyConsumption.fold(0, (a, b) => a > b ? a : b);
    double maxY = maxConsumed > maxYaxis ? maxConsumed.toDouble() : maxYaxis.toDouble();
    return unit == 'ml' ? maxY : maxY / 1000;
  }
}
