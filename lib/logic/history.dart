import 'package:intl/intl.dart';

import '../logic/storage.dart';
import 'package:dr_drink/logic/user.dart';

class History {
  // Public attributes
  List<int> recordedQuantities;
  List<String> recordedTimes;
  List<int> hourlyConsumption; // 24 hours
  List<int> weeklyConsumption; // 7 days
  List<int> monthlyConsumption; // 31 days
  DateTime? _lastRecordedTime;

  // Constructor
  History({
    List<int>? records,
    List<String>? recordedTimes,
    List<int>? hourlyConsumption,
    List<int>? weeklyConsumption,
    List<int>? monthlyConsumption,
    DateTime? lastRecordedTime,
  })  : recordedQuantities = records ?? [],
        recordedTimes = recordedTimes ?? [],
        hourlyConsumption = hourlyConsumption ?? List.filled(24, 0),
        weeklyConsumption = weeklyConsumption ?? List.filled(7, 0),
        monthlyConsumption = monthlyConsumption ?? List.filled(31, 0),
        _lastRecordedTime = lastRecordedTime ?? DateTime.now();

  // Method to add a record
  void _addRecord(int amount, String time) {
    recordedQuantities.add(amount);
    recordedTimes.add(time);
  }


  // Add to hourly consumption
  void _addHourlyConsumption(int hour, int amount) {
    hourlyConsumption[hour] += amount;
  }

  // Add to monthly consumption
  void _addMonthlyConsumption(int day, int amount) {
    monthlyConsumption[day] += amount;
  }

  // Add to weekly consumption
  void _addWeeklyConsumption(int day, int amount) {
    if (day == 7) {
      day = 0; // Adjust Sunday from DateTime (7) to our index (0)
    }
    weeklyConsumption[day] += amount;
  }

  // Clear hourly consumption data
  void _clearHourlyConsumption() {
    hourlyConsumption = List.filled(24, 0);
  }

  // Clear records
  void _clearRecords() {
    recordedQuantities = [];
    recordedTimes = [];
  }

  // clear weekly consumption data
  void _clearWeeklyConsumption() {
    weeklyConsumption = List.filled(7, 0);
  }

  // Clear monthly consumption data
  void _clearMonthlyConsumption() {
    monthlyConsumption = List.filled(31, 0);
  }

  // called when opening the app
  // called when opening the history
  // called when storing a record
  void updateLastRecordedTime(DateTime time) {
    // Ensure lastRecordedTime is not null before comparison
    if (_lastRecordedTime == null) {
      _lastRecordedTime = time;
      return;
    }

    // Daily reset: Check for a full day change (not just the day number)
    if (!_isSameDay(time, _lastRecordedTime!)) {
      _clearHourlyConsumption();
      _clearRecords();
    }

    // Weekly reset: Compare week numbers
    if (!_isSameWeek(time, _lastRecordedTime!)) {
      _clearWeeklyConsumption();
    }

    // Monthly reset: If the month changes, _clear the monthly records
    if (time.month != _lastRecordedTime!.month) {
      _clearMonthlyConsumption();
    }

    // Update the last recorded time
    _lastRecordedTime = time;
  }

// Helper to check if two dates are on the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

// Helper to check if two dates are in the same week (ISO week number)
  bool _isSameWeek(DateTime date1, DateTime date2) {
    int week1 = _getIsoWeekNumber(date1);
    int week2 = _getIsoWeekNumber(date2);
    return date1.year == date2.year && week1 == week2;
  }

// Function to get the ISO week number
  int _getIsoWeekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date)); // this gets the day of the year (1-366)
    int adjustedWeekday = (date.weekday % 7); // Convert Sunday to 0, Monday to 1, ..., Saturday to 6
    return ((dayOfYear - adjustedWeekday + 6) / 7).floor();
  }


  void storeRecord(double waterLevel, DateTime? recordedTime) {
    Storage storage = Storage();
    MyUser user = MyUser.instance;
    String unit = user.profile.unit;

    int record = unit == 'ml' ? (waterLevel * 2).truncate() : (waterLevel * 0.2).truncate() * 10;
    user.history.updateLastRecordedTime(recordedTime!);
    user.tracker.drink(record);
    user.history._addRecord(record, DateFormat('jm').format(recordedTime)); // the format will be like
    user.history._addHourlyConsumption(recordedTime.hour, record);
    user.history._addWeeklyConsumption(recordedTime.weekday, record);
    user.history._addMonthlyConsumption(recordedTime.day - 1, record);
    user.profile.addAmount(record);

    storage.saveUser(user);
  }


  // Convert to map
  Map<String, dynamic> toMap() {
    return {
      'records': recordedQuantities,
      'recordedTimes': recordedTimes,
      'hourlyConsumption': hourlyConsumption,
      'weeklyConsumption': weeklyConsumption,
      'monthlyConsumption': monthlyConsumption,
      'lastRecordedTime': _lastRecordedTime?.toIso8601String(),
    };
  }

  // Create a History object from a map
  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      records: List<int>.from(map['records']),
      recordedTimes: List<String>.from(map['recordedTimes']),
      hourlyConsumption: List<int>.from(map['hourlyConsumption']),
      weeklyConsumption: List<int>.from(map['weeklyConsumption']),
      monthlyConsumption: List<int>.from(map['monthlyConsumption']),
      lastRecordedTime: DateTime.parse(map['lastRecordedTime']),
    );
  }
}
