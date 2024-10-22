import 'package:flutter/foundation.dart';

class Profile {
  int totalAmount = 0;
  int totalDays = 1;
  bool enableNotification = true;
  String notificationSound = 'Default';
  String theme = 'Light Theme';
  String language = 'English';
  String unit = 'ml';

  static final Profile _instance = Profile._internal();

  Profile._internal();

  factory Profile({
    int? totalAmount,
    int? totalDays,
    bool? enableNotification,
    String? notificationSound,
    String? theme,
    String? language,
    String? unit,
  }) {
    _instance.totalAmount = totalAmount?? 0;
    _instance.totalDays = totalDays?? 1;
    _instance.enableNotification = enableNotification?? true;
    _instance.notificationSound = notificationSound?? 'Default';
    _instance.theme = theme?? 'Light Theme';
    _instance.language = language?? 'English';
    _instance.unit = unit?? 'ml';
    return _instance;
  }

  static Profile get instance => _instance;

  void addAmount(int amount)
  {
    totalAmount += amount;
  }

  // Profile({
  //   required this.totalAmount,
  //   required this.totalDays,
  //   required this.enableNotification,
  //   required this.notificationSound,
  //   required this.theme,
  //   required this.language,
  //   required this.unit,
  // });


  // void editProfile(
  //     {String? newTheme,
  //     String? newSound,
  //     bool? newVibration,
  //     String? newLanguage,
  //     String? newUnit}) {
  //   if (newTheme != null) theme = newTheme;
  //   if (newSound != null) notificationSound = newSound;
  //   if (newVibration != null) notification = newVibration;
  //   if (newLanguage != null) language = newLanguage;
  //   if (newUnit != null) unit = newUnit;
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'theme': theme,
  //     'notificationSound': notificationSound,
  //     'notificationVibration': notificationVibration,
  //     'language': language,
  //     'unit': unit,
  //   };
  // }
  //
  // factory Profile.fromMap(Map<String, dynamic> map) {
  //   return Profile(
  //     theme: map['theme'],
  //     notificationSound: map['notificationSound'],
  //     notificationVibration: map['notificationVibration'],
  //     language: map['language'],
  //     unit: map['unit'],
  //   );
  // }
}
