import 'package:flutter/material.dart';

class Profile {
  // Public attributes
  int totalAmount;
  int totalDays;
  String notificationSound;
  TimeOfDay notificationInterval;
  String theme;
  String language;
  String unit;

  // Constructor
  Profile({
    this.totalAmount = 0,
    this.totalDays = 1,
    this.notificationSound = '',
    this.notificationInterval = const TimeOfDay(hour: 1, minute: 0),
    this.theme = 'Light Theme',
    this.language = 'English',
    this.unit = 'ml',
  });

  // Method to add amount
  void addAmount(int amount) {
    totalAmount += amount;
  }

  // Convert Profile to a map
  Map<String, dynamic> toMap() {
    return {
      'totalAmount': totalAmount,
      'totalDays': totalDays,
      'notificationSound': notificationSound,
      'interval': _timeOfDayToString(notificationInterval),
      'theme': theme,
      'language': language,
      'unit': unit,
    };
  }

  // Create a Profile instance from a map
  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      totalAmount: map['totalAmount'] ?? 0,
      totalDays: map['totalDays'] ?? 1,
      notificationSound: map['notificationSound'] ?? 'Default',
      notificationInterval: _stringToTimeOfDay(map['interval']) ?? const TimeOfDay(hour: 1, minute: 0),
      theme: map['theme'] ?? 'Light Theme',
      language: map['language'] ?? 'English',
      unit: map['unit'] ?? 'ml',
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
