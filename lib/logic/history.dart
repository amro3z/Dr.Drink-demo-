class History{
  List<int> records = [];
  List<String> recordedTimes = [];
  List<int> hourlyConsumption = List.filled(24, 0) ;
  List<int> weeklyConsumption = List.filled(7, 0);
  List<int> monthlyConsumption = List.filled(31, 0);

  static final History _instance = History._internal();

  // Named constructor for creating the singleton instance internally
  History._internal();

  // Factory constructor that returns the same instance
  factory History({
    List<int>? records,
    List<String>? recordedTimes,
    List<int>? hourlyConsumption,
    List<int>? weeklyConsumption,
    List<int>? monthlyConsumption,
  }) {
    _instance.records = records?? [];
    _instance.recordedTimes = recordedTimes?? [];
    _instance.hourlyConsumption = hourlyConsumption?? List.filled(24, 0);
    _instance.weeklyConsumption = weeklyConsumption?? List.filled(7, 0);
    _instance.monthlyConsumption = monthlyConsumption?? List.filled(31, 0);
    return _instance;
  }

  static History get instance => _instance;

  void addRecord(int amount, String time)
  {
    records.add(amount);
    recordedTimes.add(time);
  }

  void clearRecords()
  {
    records.clear();
    recordedTimes.clear();
  }

  void addHourlyConsumption(int hour, int amount)
  {
    hourlyConsumption[hour] += amount;
  }

  void clearHourlyConsumption()
  {
    hourlyConsumption = List.filled(24, 0);
  }

  void addMonthlyConsumption(int day, int amount)
  {
    monthlyConsumption[day] += amount;
  }

  void clearMonthlyConsumption()
  {
    monthlyConsumption = List.filled(31, 0);
  }

  void addWeeklyConsumption(int day, int amount)
  {
    if (day == 7) {
      day = 0; // as 7 is Sunday in DateTime and 0 is Sunday in our case
    }
    weeklyConsumption[day] += amount;
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'records': records,
      'recordedTimes': recordedTimes,
      'hourlyConsumption': hourlyConsumption,
      'weeklyConsumption': weeklyConsumption,
      'monthlyConsumption': monthlyConsumption,
    };
  }

  // from map
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