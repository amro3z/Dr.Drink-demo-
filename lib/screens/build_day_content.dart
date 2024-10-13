import 'package:dr_drink/componnent/record_card.dart';
import 'package:dr_drink/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../values/color.dart';

class BuildDayContent extends StatelessWidget {
  final double goal;
  final String unit;
  final int time = 4;
  final List<int> hours;
  final List<double> waterConsumptionList;

  const BuildDayContent({
    super.key,
    required this.goal,
    required this.unit,
    required this.waterConsumptionList,
    required this.hours,
  });

  double get total {
    return waterConsumptionList.fold(0, (sum, item) => sum + item);
  }

  @override
  Widget build(BuildContext context) {
    // Fetch screen dimensions and scale factors
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final textHeadSize = scaleFactor * 20;

    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.02,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.arrow_back_ios),
              Text(
                'Today',
                style: TextStyle(
                  color: MyColor.blue,
                  fontFamily: 'Poppins',
                  fontSize: textHeadSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
        Positioned(
          top: screenHeight * 0.1,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.4,
                decoration: ShapeDecoration(
                  color: MyColor.blue.withOpacity(0.04),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 0.02),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: screenWidth * 0.04,
                                  color: MyColor.blue.withOpacity(0.4),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${total.toStringAsFixed(2)} $unit',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: screenWidth * 0.045,
                                  color: MyColor.blue.withOpacity(0.9),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Goal',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: screenWidth * 0.04,
                                  color: MyColor.blue.withOpacity(0.4),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${goal.toStringAsFixed(2)} $unit',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: screenWidth * 0.045,
                                  color: MyColor.blue.withOpacity(0.9),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          barTouchData: barTouchData,
                          titlesData: getTitlesData(),
                          borderData: borderData,
                          barGroups: getBarGroups(),
                          gridData: getGridData(),
                          alignment: BarChartAlignment.spaceAround,
                          maxY: goal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.02, bottom: screenHeight * 0.02),
                child: Text(
                  'Records',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: textHeadSize,
                    color: MyColor.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // Records section
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: screenHeight * 0.15,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: HomePage.interval,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(right: screenWidth * 0.04),
                              child: RecordCard(
                                quantity: waterConsumptionList[index],
                                time: HomePage.formattedTime!,
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

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

  Widget getBottomTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: MyColor.blue.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 16,
      fontFamily: 'Poppins',
    );
    String text = value.toInt().toString();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  // Y Axis Titles
  Widget getLeftTitles(double value, TitleMeta meta) {
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

  FlTitlesData getTitlesData() {
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
          reservedSize: 50,
          getTitlesWidget: getLeftTitles,
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

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          left: BorderSide(
            color: MyColor.blue.withOpacity(0.2),
            width: 1,
          ),
          bottom: BorderSide(
            color: MyColor.blue.withOpacity(0.2),
            width: 1,
          ),
          right: BorderSide.none,
          top: BorderSide.none,
        ),
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Colors.white70.withOpacity(0.5),
          MyColor.white,
          MyColor.white,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  // Generate the Bar Data
  List<BarChartGroupData> getBarGroups() {
    final barGroups = <BarChartGroupData>[];

    for (int i = 0; i < waterConsumptionList.length && i < hours.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: hours[i],
          barRods: [
            BarChartRodData(
              toY: waterConsumptionList[i],
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    return barGroups;
  }

  FlGridData getGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: true,
      verticalInterval: 4,
      drawHorizontalLine: true,
      horizontalInterval: goal / 4,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: MyColor.white,
          strokeWidth: 1,
        );
      },
    );
  }
}
