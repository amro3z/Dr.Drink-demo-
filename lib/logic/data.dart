import 'package:flutter/material.dart';

class Data {
  String? gender;
  int? age;
  int? weight;
  TimeOfDay? wakeUpTime;
  TimeOfDay? bedTime;

  Data({
    this.gender,
    this.age,
    this.weight,
    this.wakeUpTime,
    this.bedTime,
  });

  // Convert to map for saving
  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'age': age,
      'weight': weight,
      'wakeUpTime': _timeOfDayToString(wakeUpTime),
      'bedTime': _timeOfDayToString(bedTime),
    };
  }

  // Create Data from a map
  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      gender: map['gender'],
      age: map['age'],
      weight: map['weight'],
      wakeUpTime: _stringToTimeOfDay(map['wakeUpTime']),
      bedTime: _stringToTimeOfDay(map['bedTime']),
    );
  }

  // Helper function: Convert TimeOfDay to string
  static String _timeOfDayToString(TimeOfDay? time) {
    if (time == null) return '';
    return '${time.hour}:${time.minute}'; // Format as "HH:mm"
  }

  // Helper function: Convert string back to TimeOfDay
  static TimeOfDay? _stringToTimeOfDay(String? time) {
    if (time == null || time.isEmpty) return null;
    final parts = time.split(':'); // Split "HH:mm"
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
