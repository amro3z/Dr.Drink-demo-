class Tracker {
  // Attributes
  double cupSize;
  double totalWaterGoal;
  double totalWaterConsumed;

  // Constructor
  Tracker({
    required this.cupSize,
    required this.totalWaterGoal,
    this.totalWaterConsumed = 0, // Initialize with 0 by default
  });

  // Method to change the cup size
  void changeCupSize(double newCupSize) {
    if (newCupSize > 0) {
      cupSize = newCupSize;
    }
  }

  // Method to simulate drinking water (adds to totalWaterConsumed)
  void drink() {
    totalWaterConsumed += cupSize;
  }
}
