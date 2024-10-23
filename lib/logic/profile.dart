class Profile {
  // Public attributes
  int totalAmount;
  int totalDays;
  bool enableNotification;
  String notificationSound;
  String theme;
  String language;
  String unit;

  // Constructor
  Profile({
    this.totalAmount = 0,
    this.totalDays = 1,
    this.enableNotification = true,
    this.notificationSound = 'Default',
    this.theme = 'Light Theme',
    this.language = 'English',
    this.unit = 'ml',
  });

  // Method to add amount
  void addAmount(int amount) {
    totalAmount += amount;
  }

  // Method to add day
  void addDay() {
    totalDays++;
  }

  // Convert Profile to a map
  Map<String, dynamic> toMap() {
    return {
      'totalAmount': totalAmount,
      'totalDays': totalDays,
      'enableNotification': enableNotification,
      'notificationSound': notificationSound,
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
      enableNotification: map['enableNotification'] ?? true,
      notificationSound: map['notificationSound'] ?? 'Default',
      theme: map['theme'] ?? 'Light Theme',
      language: map['language'] ?? 'English',
      unit: map['unit'] ?? 'ml',
    );
  }
}
