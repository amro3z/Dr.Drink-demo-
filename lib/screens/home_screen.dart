import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  double _waterConsumed = 0; // Water consumed by the user
  // get the value from shared preferences
  double _waterGoal = 0; // Water goal for the user

  @override
  void initState() {
    super.initState();
    getWaterConsumed();
    getWaterGoal();
  }

  void _submitValue() {
    setState(() {
      try {
        // Parse the input value
        double submittedValue = double.parse(_controller.text);

        // Increase water consumed by the input amount
        _waterConsumed += submittedValue;
        saveWaterConsumed();
        // Update the list of consumed quantities
        HomePage.interval++;
        HomePage.quantityValues.add(submittedValue);

        // Record the current time for logging
        DateTime recordedTime = DateTime.now();
        int hours = recordedTime.hour;
        HomePage.formattedTime = DateFormat.jm().format(recordedTime);
        HomePage.hours.add(hours);

        // Clear the input field
        _controller.clear();
      } catch (e) {
        // Handle invalid input (non-numeric values)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid input! Please enter a valid number.'),
          ),
        );
      }
    });
  }

  // function to get the water consumed from shared preferences
  void getWaterConsumed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? waterConsumed = prefs.getDouble('waterConsumed');
    if (waterConsumed != null) {
      setState(() {
        _waterConsumed = waterConsumed;
      });
    }
  }

  // function to save the water consumed in shared preferences
  void saveWaterConsumed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('waterConsumed', _waterConsumed);
  }

  // function to get the water goal from shared preferences
  void getWaterGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? waterGoal = prefs.getDouble('waterGoal');
    if (waterGoal != null) {
      setState(() {
        _waterGoal = waterGoal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display water consumed / water goal
            Text(
              'Water consumed: $_waterConsumed ml / $_waterGoal ml',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Input field for drinking water amount
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter amount (ml)',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*\.?[0-9]*')),
              ],
            ),
            SizedBox(height: 16),
            // Drink button
            ElevatedButton(
              onPressed: _submitValue,
              child: Text('Drink!'),
            ),
            SizedBox(height: 16),
            // Show formatted time of last drink (optional)
            if (HomePage.formattedTime != null)
              Text(
                'Last drink at: ${HomePage.formattedTime}',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
