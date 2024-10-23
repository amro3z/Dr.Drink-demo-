
class Data {
  String? gender;
  int? age;
  int? weight;
  String? wakeUpTime;
  String? bedTime;

  Data({
    this.gender,
    this.age,
    this.weight,
    this.wakeUpTime,
    this.bedTime,
  });

  // Convert to map
  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'age': age,
      'weight': weight,
      'wakeUpTime': wakeUpTime,
      'bedTime': bedTime,
    };
  }

  // Create Data from map
  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      gender: map['gender'],
      age: map['age'],
      weight: map['weight'],
      wakeUpTime: map['wakeUpTime'],
      bedTime: map['bedTime'],
    );
  }
}