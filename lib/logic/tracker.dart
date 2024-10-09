class Tracker {
  // Attributes
  double cupSize;
  double waterGoal;
  double waterConsumed;

  // Constructor
  Tracker({
    required this.cupSize,
    required this.waterGoal,
    this.waterConsumed = 0.0, // Initialize with 0 by default
  });

  // Method to change the cup size
  void changeCupSize(double newCupSize) {
    if (newCupSize > 0) {
      cupSize = newCupSize;
    }
  }

  // Method to simulate drinking water (adds to waterConsumed)
  void drink() {
    waterConsumed += cupSize;
  }
}
