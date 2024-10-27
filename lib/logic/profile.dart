class Profile {
  // Public attributes
  int totalAmount;
  bool enableNotification;
  String notificationSound;
  int intervalHours;
  int intervalMinutes;
  String theme;
  String language;
  String unit;

  // Constructor
  Profile({
    this.totalAmount = 0,
    this.enableNotification = true,
    this.notificationSound = '',
    this.intervalHours = 1,
    this.intervalMinutes = 0,
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
      'enableNotification': enableNotification,
      'notificationSound': notificationSound,
      'intervalHours': intervalHours,
      'intervalMinutes': intervalMinutes,
      'theme': theme,
      'language': language,
      'unit': unit,
    };
  }

  // Create a Profile instance from a map
  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      totalAmount: map['totalAmount'] ?? 0,
      enableNotification: map['enableNotification'] ?? true,
      notificationSound: map['notificationSound'] ?? 'Default',
      intervalHours: map['intervalHours'] ?? 1,
      intervalMinutes: map['intervalMinutes'] ?? 0,
      theme: map['theme'] ?? 'Light Theme',
      language: map['language'] ?? 'English',
      unit: map['unit'] ?? 'ml',
    );
  }
}
