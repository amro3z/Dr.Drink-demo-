import 'dart:convert';
// import 'dart:math';

import 'package:dr_drink/logic/tracker.dart';
import 'dart:developer';
import 'package:flutter/material.dart';

class MyUser {
  // Singleton instance
  static final MyUser _instance = MyUser._internal();

  // Factory constructor that returns the same instance
  factory MyUser({
    required String gender,
    required int age,
    required int weight,
    required String wakeUpTime,
    required String breakfastTime,
    required String lunchTime,
    required String dinnerTime,
    required String bedTime,
    Tracker? tracker,
    String? unit,
  }) {
    _instance.gender = gender;
    _instance.age = age;
    _instance.weight = weight;
    _instance.wakeUpTime = wakeUpTime;
    _instance.breakfastTime = breakfastTime;
    _instance.lunchTime = lunchTime;
    _instance.dinnerTime = dinnerTime;
    _instance.bedTime = bedTime;
    _instance.tracker = tracker?? Tracker();
    _instance.unit = unit;
    return _instance;
  }

  // Named constructor for creating the singleton instance internally
  MyUser._internal();

  // Attributes
  String gender = '';
  int age = 0;
  int weight = 0;
  String wakeUpTime = '';
  String breakfastTime = '';
  String lunchTime = '';
  String dinnerTime = '';
  String bedTime = '';
  Tracker tracker = Tracker();
  String? unit;

  // // Method to calculate water goal
  // int calculateWaterGoal() {
  //   totalWaterGoal = weight * 33;
  //   return totalWaterGoal!;
  // }

  static MyUser get instance => _instance;

  // Method to edit profile details
  void editProfile({
    String? newGender,
    int? newAge,
    int? newWeight,
    String? newWakeUpTime,
    String? newBedTime,
  }) {
    if (newGender != null) gender = newGender;
    if (newAge != null) age = newAge;
    if (newWeight != null) weight = newWeight;
    if (newWakeUpTime != null) wakeUpTime = newWakeUpTime;
    if (newBedTime != null) bedTime = newBedTime;

    // Recalculate water goal after editing profile
    // calculateWaterGoal();
  }

  // void drinkWater(int amount) {
  //   totalWaterConsumed = totalWaterConsumed! + amount;
  // }

  // Convert to map
  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'age': age,
      'weight': weight,
      'wakeUpTime': wakeUpTime,
      'breakfastTime': breakfastTime,
      'lunchTime': lunchTime,
      'dinnerTime': dinnerTime,
      'bedTime': bedTime,
      'tracker': json.encode(tracker.toMap()),
      'unit': unit,
    };
  }

  // Create a MyUser instance from a map
  factory MyUser.fromMap(Map<String, dynamic> map) {
    log("here----------------------------");
    return MyUser(
      gender: map['gender'],
      age: map['age'],
      weight: map['weight'],
      wakeUpTime: map['wakeUpTime'],
      breakfastTime: map['breakfastTime'],
      lunchTime: map['lunchTime'],
      dinnerTime: map['dinnerTime'],
      bedTime: map['bedTime'],
      tracker: Tracker.fromMap(json.decode(map['tracker'])),
      unit: map['unit'],
    );
  }
}
