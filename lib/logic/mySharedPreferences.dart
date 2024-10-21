import 'package:dr_drink/logic/user.dart';

class MySharedPreferences {
  // Method to get an instance of SharedPreferences
  static Future<MySharedPreferences> getInstance() async {
    return MySharedPreferences();
  }

  // Method to store an integer value
  Future<bool> setInt(String key, int value) async {
    return true;
  }

  // Method to store a string value
  Future<bool> setString(String key, String value) async {
    return true;
  }

  // Method to get an integer value
  int getInt(String key) {
    return 0;
  }

  // Method to get a string value
  String getString(String key) {
    return '';
  }

  // Method to save user
  Future<bool> saveUser(MyUser user) async {
    setInt('age', user.age);
    setInt('weight', user.weight);
    setString('gender', user.gender);
    setString('wakeUpTime', user.wakeUpTime.toString());
    setString('breakfastTime', user.breakfastTime.toString());
    setString('lunchTime', user.lunchTime.toString());
    setString('dinnerTime', user.dinnerTime.toString());
    setString('bedTime', user.bedTime.toString());
    return true;
  }

  // Method to get user
  Future<MyUser?> getUser() async {

    // Retrieve the user data from SharedPreferences
    int? age = getInt('age');
    int? weight = getInt('weight');
    String? gender = getString('gender');
    String? wakeUpTime = getString('wakeUpTime');
    String? breakfastTime = getString('breakfastTime');
    String? lunchTime = getString('lunchTime');
    String? dinnerTime = getString('dinnerTime');
    String? bedTime = getString('bedTime');


    print('user data $gender $age $weight $wakeUpTime $bedTime');
    // Check if any of the data is null (meaning it's not stored yet)
    if (gender.isEmpty || wakeUpTime.isEmpty || bedTime.isEmpty) {
      return null; // No user data stored
    }
    return MyUser(
      age: age,
      weight: weight,
      gender: gender,
      wakeUpTime: wakeUpTime,
      breakfastTime: breakfastTime,
      lunchTime: lunchTime,
      dinnerTime: dinnerTime,
      bedTime: bedTime,
    );
  }
}