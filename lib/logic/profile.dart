class Profile {
  String theme;
  String notificationSound;
  bool notificationVibration;
  String language;
  String unit;

  Profile({
    required this.theme,
    required this.notificationSound,
    required this.notificationVibration,
    required this.language,
    required this.unit,
  });

  void editProfile(
      {String? newTheme,
      String? newSound,
      bool? newVibraion,
      String? newLanguage,
      String? newUnit}) {
    if (newTheme != null) theme = newTheme;
    if (newSound != null) notificationSound = newSound;
    if (newVibraion != null) notificationVibration = newVibraion;
    if (newLanguage != null) language = newLanguage;
    if (newUnit != null) unit = newUnit;
  }

  Map<String, dynamic> toMap() {
    return {
      'theme': theme,
      'notificationSound': notificationSound,
      'notificationVibration': notificationVibration,
      'language': language,
      'unit': unit,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      theme: map['theme'],
      notificationSound: map['notificationSound'],
      notificationVibration: map['notificationVibration'],
      language: map['language'],
      unit: map['unit'],
    );
  }
}
