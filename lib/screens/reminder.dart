import 'package:flutter/material.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  bool reminder = false;
  bool afterWalkUp = false;
  bool beforeBreakfast = false;
  bool afterBreakfast = false;
  bool beforeLunch = false;
  bool afterLunch = false;
  bool beforeDinner = false;
  bool afterDinner = false;
  bool beforeSleep = false;
  bool reminderWeek = false;
  bool stopGoal = false;
  bool smartSkip = false;

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
                  const Spacer(
                    flex: 3,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reminder",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Next: 06:00 PM (1h 27 min left)",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 25,
                  ),
                  Switch(
                    activeColor: Colors.blueAccent,
                    value: reminder,
                    onChanged: (value) {
                      setState(() {
                        reminder = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              color: Colors.white,
              child: const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Reminder Mode",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Standard",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(122, 0, 0, 0),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.edit,
                    color: Color.fromARGB(122, 0, 0, 0),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Can't receive reminder?",
                style: TextStyle(
                    color: Color.fromARGB(122, 0, 0, 0),
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromARGB(122, 0, 0, 0)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomRow(
              swicht: Switch(
                activeColor: Colors.blueAccent,
                value: afterWalkUp,
                onChanged: (value) {
                  setState(() {
                    afterWalkUp = value;
                  });
                },
              ),
              label: "After Wake-up",
              time: const TimeOfDay(hour: 8, minute: 0),
            ),
            const SizedBox(
              height: 1,
            ),
            CustomRow(
              swicht: Switch(
                activeColor: Colors.blueAccent,
                value: beforeBreakfast,
                onChanged: (value) {
                  setState(() {
                    beforeBreakfast = value;
                  });
                },
              ),
              label: "Before Breakfast",
              time: const TimeOfDay(hour: 8, minute: 0),
            ),
            const SizedBox(
              height: 1,
            ),
            CustomRow(
              swicht: Switch(
                activeColor: Colors.blueAccent,
                value: afterBreakfast,
                onChanged: (value) {
                  setState(() {
                    afterBreakfast = value;
                  });
                },
              ),
              label: "After Breakfast",
              time: const TimeOfDay(hour: 8, minute: 0),
            ),
            const SizedBox(
              height: 1,
            ),
            CustomRow(
              swicht: Switch(
                activeColor: Colors.blueAccent,
                value: beforeLunch,
                onChanged: (value) {
                  setState(() {
                    beforeLunch = value;
                  });
                },
              ),
              label: "Before Lunch",
              time: const TimeOfDay(hour: 8, minute: 0),
            ),
            const SizedBox(
              height: 1,
            ),
            CustomRow(
              swicht: Switch(
                activeColor: Colors.blueAccent,
                value: afterLunch,
                onChanged: (value) {
                  setState(() {
                    afterLunch = value;
                  });
                },
              ),
              label: "After Lunch",
              time: const TimeOfDay(hour: 8, minute: 0),
            ),
            const SizedBox(
              height: 1,
            ),
            CustomRow(
              swicht: Switch(
                activeColor: Colors.blueAccent,
                value: beforeDinner,
                onChanged: (value) {
                  setState(() {
                    beforeDinner = value;
                  });
                },
              ),
              label: "Before Dinner",
              time: const TimeOfDay(hour: 8, minute: 0),
            ),
            const SizedBox(
              height: 1,
            ),
            CustomRow(
              swicht: Switch(
                activeColor: Colors.blueAccent,
                value: afterDinner,
                onChanged: (value) {
                  setState(() {
                    afterDinner = value;
                  });
                },
              ),
              label: "After Dinner",
              time: const TimeOfDay(hour: 8, minute: 0),
            ),
            const SizedBox(
              height: 1,
            ),
            CustomRow(
              swicht: Switch(
                activeColor: Colors.blueAccent,
                value: beforeSleep,
                onChanged: (value) {
                  setState(() {
                    beforeSleep = value;
                  });
                },
              ),
              label: "Before Sleep",
              time: const TimeOfDay(hour: 8, minute: 0),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomRow(
              swicht: Switch(
                activeColor: Colors.blueAccent,
                value: reminderWeek,
                onChanged: (value) {
                  setState(() {
                    reminderWeek = value;
                  });
                },
              ),
              label: "Reminder Week end mode ",
              time: null,
              isIcon: false,
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Skip & Stop",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomRow(
              swicht: Switch(
                activeColor: Colors.blueAccent,
                value: stopGoal,
                onChanged: (value) {
                  setState(() {
                    stopGoal = value;
                  });
                },
              ),
              label: "Stop when goal achieved",
              isIcon: false,
            ),
            CustomRow(
              swicht: Switch(
                activeColor: Colors.blueAccent,
                value: smartSkip,
                onChanged: (value) {
                  setState(() {
                    smartSkip = value;
                  });
                },
              ),
              label: "Smart Skip",
              text: const Text(
                "1 hour",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(122, 0, 0, 0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomRow extends StatefulWidget {
  const CustomRow({
    super.key,
    required this.label,
    this.time,
    this.isIcon = true,
    this.text = const SizedBox(),
    this.onChanged,
    required this.swicht,
  });

  final void Function(bool)? onChanged;
  final String label;
  final TimeOfDay? time;
  final bool isIcon;
  final Widget text;
  final Widget swicht;

  @override
  State<CustomRow> createState() => _CustomRowState();
}

class _CustomRowState extends State<CustomRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          widget.text,
          Text(
            widget.time == null ? "" : widget.time!.format(context),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(122, 0, 0, 0),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          widget.isIcon
              ? const Icon(
            Icons.edit,
            color: Color.fromARGB(122, 0, 0, 0),
          )
              : Container(),
          widget.swicht,
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}