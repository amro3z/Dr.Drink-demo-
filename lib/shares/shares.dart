import 'package:flutter/material.dart';

class AppBaricon extends StatelessWidget {
  AppBaricon(
      {super.key,
      required this.path,
      this.onTap,
      this.colorIcon = Colors.black});
  final String path;
  final VoidCallback? onTap;
  final Color colorIcon;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Image.asset(
            path,
            width: 40,
            height: 40,
            color: colorIcon,
          ),
        ),
      ),
    );
  }
}

class WheelList extends StatelessWidget {
  final FixedExtentScrollController scroll;
  final int selectedItem;
  final int start;
  final int end;
  final ValueChanged<int> onSelectedItemChanged;
  WheelList(
      {super.key,
      required this.scroll,
      required this.selectedItem,
      required this.start,
      required this.end,
      required this.onSelectedItemChanged,
      req});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400,
        child: ListWheelScrollView.useDelegate(
          controller: scroll, // استخدام الـ controller
          itemExtent: 50, // المسافة بين كل عنصر
          onSelectedItemChanged: (index) {
            final selectedValue = index + start;
            onSelectedItemChanged(
                selectedValue); // تمرير القيمة المختارة للويدجيت الأب
          },
          perspective: 0.003,
          physics: const FixedExtentScrollPhysics(),
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              final item = index + start; // الأرقام تبدأ من 40
              return Center(
                child: Text(
                  item.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: selectedItem == item
                        ? Colors.black
                        : Colors.grey, // تمييز الرقم المختار
                  ),
                ),
              );
            },
            childCount: end - start + 1, // الأرقام من start إلى end
          ),
        ),
      ),
    );
  }
}

class TimeWheel extends StatelessWidget {
  final FixedExtentScrollController controller; // إضافة المتحكم
  final int selectedItem;
  final int start;
  final int end;
  final ValueChanged<int> onSelectedItemChanged;
  final bool padWithZero;
  final double height;
  final double width;
  final double fontSize;
  const TimeWheel({
    Key? key,
    required this.controller, // إضافة المتحكم كمعامل
    required this.selectedItem,
    required this.start,
    required this.end,
    required this.onSelectedItemChanged,
    this.padWithZero = false,
    required this.height,
    this.width = 60.0,
    this.fontSize = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ListWheelScrollView.useDelegate(
        controller: controller, // استخدم المتحكم
        itemExtent: 50,
        onSelectedItemChanged: (index) {
          onSelectedItemChanged(index + start);
        },
        physics: const FixedExtentScrollPhysics(),
        perspective: 0.003,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            final item = index + start;
            final itemText = padWithZero
                ? item.toString().padLeft(2, '0')
                : item.toString(); // لضمان أن تكون الدقائق بصيغة 00

            return Center(
              child: Text(
                itemText,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: selectedItem == item ? Colors.black : Colors.grey,
                ),
              ),
            );
          },
          childCount: end - start + 1,
        ),
      ),
    );
  }
}

// AmPmWheel ويدجيت مخصص لـ AM/PM
class AmPmWheel extends StatelessWidget {
  final FixedExtentScrollController controller; // إضافة المتحكم
  final String selectedItem;
  final ValueChanged<String> onSelectedItemChanged;
  final double height;
  final double width;
  final double fontSize;

  const AmPmWheel({
    Key? key,
    required this.controller, // إضافة المتحكم كمعامل
    required this.selectedItem,
    required this.onSelectedItemChanged,
    required this.height,
    this.width = 80.0,
    this.fontSize = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: 80,
      child: ListWheelScrollView.useDelegate(
        controller: controller, // استخدم المتحكم
        itemExtent: 50,
        onSelectedItemChanged: (index) {
          final period = index == 0 ? "AM" : "PM";
          onSelectedItemChanged(period);
        },
        physics: const FixedExtentScrollPhysics(),
        perspective: 0.003,
        childDelegate: ListWheelChildListDelegate(
          children: [
            Center(
              child: Text(
                "AM",
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: selectedItem == "AM" ? Colors.black : Colors.grey,
                ),
              ),
            ),
            Center(
              child: Text(
                "PM",
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: selectedItem == "PM" ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildMealTimeSection(
    {required String mealLabel,
    required String timeLabel,
    required int hour,
    required int minute,
    required String perioed,
    required FixedExtentScrollController hourController,
    required FixedExtentScrollController minuteController,
    required FixedExtentScrollController periodController,
    required ValueChanged<int> onHourChanged,
    required ValueChanged<int> onMinuteChanged,
    required ValueChanged<String> onPeriodChanged,
      required BuildContext context,
    final double fontSize = 30.0}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mealLabel,
            style: const TextStyle(
                color: Colors.blue,
                fontSize: 23,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
          Text(
            timeLabel,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(
        width: screenWidth * 0.042,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Wheel for hours
          TimeWheel(
            height: 120,
            controller: hourController,
            selectedItem: hour,
            start: 1,
            end: 12,
            onSelectedItemChanged: onHourChanged,
            fontSize: fontSize,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              ":",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // Wheel for minutes
          TimeWheel(
            height: 120,
            controller: minuteController,
            selectedItem: minute,
            start: 0,
            end: 59,
            padWithZero: true,
            onSelectedItemChanged: onMinuteChanged,
            fontSize: fontSize,
          ),
          // Wheel for AM/PM
          AmPmWheel(
            height: 120,
            controller: periodController,
            selectedItem: perioed,
            onSelectedItemChanged: onPeriodChanged,
            fontSize: fontSize,
          ),
        ],
      ),
    ],
  );
}

class AnimatedGender extends StatelessWidget {
  const AnimatedGender({
    super.key,
    required this.path,
    required this.text,
    required this.isSelected,
    this.onTap,
  });

  final String path;
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isSelected ? 1.0 : 0.2,
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              path,
              width: 175,
              height: 175,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 26,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Color(0xff4970CD),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
