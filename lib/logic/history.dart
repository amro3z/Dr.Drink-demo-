class History {
  // Public attributes
  List<int> records;
  List<String> recordedTimes;
  List<int> hourlyConsumption;
  List<int> weeklyConsumption;
  List<int> monthlyConsumption;

  // Constructor
  History({
    List<int>? records,
    List<String>? recordedTimes,
    List<int>? hourlyConsumption,
    List<int>? weeklyConsumption,
    List<int>? monthlyConsumption,
  })  : records = records ?? [],
        recordedTimes = recordedTimes ?? [],
        hourlyConsumption = hourlyConsumption ?? List.filled(24, 0),
        weeklyConsumption = weeklyConsumption ?? List.filled(7, 0),
        monthlyConsumption = monthlyConsumption ?? List.filled(31, 0);

  // Method to add a record
  void addRecord(int amount, String time) {
    records.add(amount);
    recordedTimes.add(time);
  }

  // Clear all records
  void clearRecords() {
    records.clear();
    recordedTimes.clear();
  }

  // Add to hourly consumption
  void addHourlyConsumption(int hour, int amount) {
    hourlyConsumption[hour] += amount;
  }

  // Clear hourly consumption data
  void clearHourlyConsumption() {
    hourlyConsumption = List.filled(24, 0);
  }

  // Add to monthly consumption
  void addMonthlyConsumption(int day, int amount) {
    monthlyConsumption[day] += amount;
  }

  // Clear monthly consumption data
  void clearMonthlyConsumption() {
    monthlyConsumption = List.filled(31, 0);
  }

  // Add to weekly consumption
  void addWeeklyConsumption(int day, int amount) {
    if (day == 7) {
      day = 0; // Adjust Sunday from DateTime (7) to our index (0)
    }
    weeklyConsumption[day] += amount;
  }

  // Convert to map
  Map<String, dynamic> toMap() {
    return {
      'records': records,
      'recordedTimes': recordedTimes,
      'hourlyConsumption': hourlyConsumption,
      'weeklyConsumption': weeklyConsumption,
      'monthlyConsumption': monthlyConsumption,
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
    );
  }
}
