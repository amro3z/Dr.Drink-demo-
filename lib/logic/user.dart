class MyUser {
  String gender;
  int age;
  int weight;
  String wakeUpTime;
  String breakfastTime;
  String lunchTime;
  String dinnerTime;
  String bedTime;
  double? totalWaterGoal;

  MyUser({
    required this.gender,
    required this.age,
    required this.weight,
    required this.wakeUpTime,
    required this.breakfastTime,
    required this.lunchTime,
    required this.dinnerTime,
    required this.bedTime,
    this.totalWaterGoal,
  });

  double calculateWaterGoal() {
    // // Base formula: weight * 0.033 (in liters)
    // double baseWaterGoal = weight * 0.033;
    //
    // // Adjust based on gender
    // if (gender.toLowerCase() == 'male') {
    //   totalWaterGoal = baseWaterGoal + 0.5;
    // } else {
    //   totalWaterGoal = baseWaterGoal;
    // }
    //
    // // Adjust based on age
    // if (age < 30) {
    //   totalWaterGoal = (totalWaterGoal ?? 0) + 0.2;
    // } else if (age > 55) {
    //   totalWaterGoal = (totalWaterGoal ?? 0) - 0.2;
    // }

    totalWaterGoal = weight * 33;
    return totalWaterGoal!;
  }

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
    calculateWaterGoal();
  }

  // to map
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
      'totalWaterGoal': totalWaterGoal,
    };
  }

  // from map
  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      gender: map['gender'],
      age: map['age'],
      weight: map['weight'],
      wakeUpTime: map['wakeUpTime'],
      breakfastTime: map['breakfastTime'],
      lunchTime: map['lunchTime'],
      dinnerTime: map['dinnerTime'],
      bedTime: map['bedTime'],
      totalWaterGoal: map['totalWaterGoal'],
    );
  }
}
