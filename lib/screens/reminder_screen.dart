import 'dart:developer';

import 'package:dr_drink/logic/storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../logic/notifications.dart';
import '../logic/user.dart';
import '../values/color.dart'; // Assuming this contains your custom blue color

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  final MyUser _user = MyUser.instance;
  Storage storage = Storage();
  int selectedHour = 1;
  int selectedMinute = 50;
  TimeOfDay wakeUpTime = const TimeOfDay(hour: 6, minute: 0);
  TimeOfDay bedTime = const TimeOfDay(hour: 22, minute: 0);

  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  @override
  void initState() {
    super.initState();
    selectedHour = _user.profile.interval.hour;
    selectedMinute = _user.profile.interval.minute;
    wakeUpTime = _user.data.wakeUpTime!;
    bedTime = _user.data.bedTime!;

    hourController = FixedExtentScrollController(initialItem: selectedHour);
    minuteController = FixedExtentScrollController(initialItem: selectedMinute ~/ 10);
  }

  // Function to generate reminder times
  String _generateReminderTimes() {
    final List<String> times = [];
    DateTime currentTime = DateTime.now();

    // Set wake-up time
    DateTime wakeUp = DateTime(currentTime.year, currentTime.month, currentTime.day, wakeUpTime.hour, wakeUpTime.minute);
    DateTime bedTime = DateTime(currentTime.year, currentTime.month, currentTime.day, this.bedTime.hour, this.bedTime.minute);
    // log('Wake-up time: ${DateFormat.jm().format(wakeUp)}');
    // log('Bed time: ${DateFormat.jm().format(bedTime)}');

    if(bedTime.isBefore(wakeUp)) {
      bedTime = bedTime.add(const Duration(days: 1));
    }

    // Calculate reminder times based on the selected interval
    while (true) {
      wakeUp = wakeUp.add(Duration(hours: selectedHour, minutes: selectedMinute));
      if (wakeUp.isAfter(bedTime) || wakeUp.isAtSameMomentAs(bedTime)) {
        break;
      }
      times.add(DateFormat.jm().format(wakeUp));
      log('Reminder time: ${DateFormat.jm().format(wakeUp)}');
    }

    return times.join(', '); // Join times with a comma for display
  }

  Future<void> _showIntervalPicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 300,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Select Interval',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Hour Picker
                              Expanded(
                                child: ListWheelScrollView.useDelegate(
                                  controller: hourController,
                                  itemExtent: 50,
                                  perspective: 0.005,
                                  physics: const FixedExtentScrollPhysics(),
                                  onSelectedItemChanged: (value) {
                                    setModalState(() {
                                      selectedHour = value;

                                      if (selectedHour == 0 && selectedMinute == 0) {
                                        selectedMinute = 10;
                                        minuteController.jumpToItem(1);
                                      }
                                    });
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    builder: (context, index) {
                                      bool isSelected = index == hourController.selectedItem;
                                      return Center(
                                        child: Text(
                                          '$index hour',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                            color: isSelected ? MyColor.blue : Colors.black54,
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: 4, // 0 to 3 hours
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Minute Picker
                              Expanded(
                                child: ListWheelScrollView.useDelegate(
                                  controller: minuteController,
                                  itemExtent: 50,
                                  perspective: 0.005,
                                  physics: const FixedExtentScrollPhysics(),
                                  onSelectedItemChanged: (value) {
                                    setModalState(() {
                                      selectedMinute = value * 10;

                                      if (selectedHour == 0 && selectedMinute == 0) {
                                        selectedMinute = 10;
                                        minuteController.jumpToItem(1);
                                      }
                                    });
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    builder: (context, index) {
                                      int minuteValue = index * 10;
                                      bool isSelected = index == minuteController.selectedItem;
                                      return Center(
                                        child: Text(
                                          '$minuteValue min',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                            color: isSelected ? MyColor.blue : Colors.black54,
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: 6, // 0 to 50 minutes in steps of 10
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        hourController = FixedExtentScrollController(initialItem: selectedHour);
                        minuteController = FixedExtentScrollController(initialItem: selectedMinute ~/ 10);
                        _user.profile.interval = TimeOfDay(hour: selectedHour, minute: selectedMinute);
                        LocalNotificationService.generateSchedule(_user.data.wakeUpTime!, _user.data.bedTime!, _user.profile.interval);
                        LocalNotificationService.schedule();
                        storage.saveUser(_user);
                        Navigator.pop(context);
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: MyColor.blue,
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showTimePicker(BuildContext context, bool isWakeUp) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isWakeUp ? wakeUpTime : bedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: MyColor.blue, // Header color (Blue)
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: MyColor.blue, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        if (isWakeUp) {
          wakeUpTime = pickedTime;
        } else {
          bedTime = pickedTime;
        }
        _user.data.wakeUpTime = wakeUpTime; // 6:00 AM
        _user.data.bedTime = bedTime;
        LocalNotificationService.generateSchedule(_user.data.wakeUpTime!, _user.data.bedTime!, _user.profile.interval);
        LocalNotificationService.schedule();
        storage.saveUser(_user);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff7f7ff),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Reminder",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Interval Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () => _showIntervalPicker(context),
                // behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Interval',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          '$selectedHour hour(s) $selectedMinute min(s)',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: MyColor.blue,
                          ),
                        ),
                        const SizedBox(width: 4), // Adds some space between text and icon
                        const Icon(
                          Icons.edit,
                          color: MyColor.blue, // Match the icon color with your theme
                          size: 20, // Adjust the size of the pin icon
                        ),
                      ],
                    ),
                  ],
                ),

              ),
            ),
            const SizedBox(height: 30),
            // Awake Time Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Awake',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showTimePicker(context, true),
                        child: Text(
                          wakeUpTime.format(context),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: MyColor.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4), // Adds some space between text and icon
                      const Icon(
                        Icons.edit,
                        color: MyColor.blue, // Match the icon color with your theme
                        size: 20, // Adjust the size of the pin icon
                      ),
                      const Text(' To ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      GestureDetector(
                        onTap: () => _showTimePicker(context, false),
                        child: Text(
                          bedTime.format(context),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: MyColor.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4), // Adds some space between text and icon
                      const Icon(
                        Icons.edit,
                        color: MyColor.blue, // Match the icon color with your theme
                        size: 20, // Adjust the size of the pin icon
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20), // Space before the explanation text
            // line separator
            Container(
              height: 1,
              color: Colors.grey[300],
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            const SizedBox(height: 20), // Space after the line separator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'We\'ll remind you every $selectedHour hour(s) $selectedMinute min(s) along the day after you start till before you sleep. Here are the times:',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8), // Space between explanation and times
                  // Generate and display reminder times
                  Text(
                    _generateReminderTimes(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}