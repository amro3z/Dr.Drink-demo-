class Tracker {
  int? totalWaterGoal;
  int totalWaterConsumed;

  // Constructor
  Tracker({
    this.totalWaterGoal,
    this.totalWaterConsumed = 0, // Initialize with 0 by default
  }){
    // calculateWaterGoal(weight);
  }

  int calculateWaterGoal(int weight) {
    totalWaterGoal = weight * 33;
    return totalWaterGoal!;
  }

  double getProgress(){
    return totalWaterConsumed / totalWaterGoal!;
  }

  // Method to simulate drinking water (adds to totalWaterConsumed)
  void drink(int amount) {
    totalWaterConsumed += amount;
  }

  // Convert to map
  Map<String, dynamic> toMap() {
    return {
      'totalWaterGoal': totalWaterGoal,
      'totalWaterConsumed':totalWaterConsumed,
    };
  }

  // Create a MyUser instance from a map
  factory Tracker.fromMap(Map<String, dynamic> map) {
    return Tracker(
      totalWaterGoal: map['totalWaterGoal'],
      totalWaterConsumed: map['totalWaterConsumed'],
    );
  }
}
