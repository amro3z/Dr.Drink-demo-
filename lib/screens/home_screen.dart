import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  static List<double> quantityValues = [];
  static List<int> hours = [];
  static int interval = 0;
  static String? formattedTime;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  double? _submittedValue;
  DateTime? _recordedTime;
  void _submitValue() {
    setState(() {
      try {
        HomePage.interval++;

        _submittedValue = double.parse(_controller.text);

        HomePage.quantityValues.add(_submittedValue ?? 0);

        _recordedTime = DateTime.now();
        int hours = _recordedTime!.hour;
        HomePage.formattedTime = DateFormat.jm().format(_recordedTime!);

        HomePage.hours.add(hours);

        print(HomePage.quantityValues);
        print(HomePage.hours);

        _controller.clear();
      } catch (e) {
        _submittedValue = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid input! Please enter a valid number.'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter a number',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*\.?[0-9]*')),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitValue,
              child: Text('Drink!'),
            ),
          ],
        ),
      ),
    );
  }
}
