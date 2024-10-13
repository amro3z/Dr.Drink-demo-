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
