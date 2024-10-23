import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dr_drink/logic/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'history.dart';

class Storage {
  // Method to check credentials
  Future<bool> checkCredentials() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      log('****************************offline');
      return checkUserAuthLocally();
    } else {
      log('****************************online');
      await Future.delayed(const Duration(seconds: 3)); // Simulate a delay
      if (FirebaseAuth.instance.currentUser == null) {
        return false; // User not authenticated
      } else {
        // Load user data from Firestore
        bool userLoaded = await loadUserFromFirestoreAndStoreLocally();
        return userLoaded; // Returns true if user data loaded successfully
      }
    }
  }

  // Check if the user has already entered their data
  Future<bool> checkUserAuthLocally() async {
    await Future.delayed(const Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isUserRegistered = prefs.getBool('isUserRegistered');

    if (isUserRegistered == true) {
      // Load user and history from shared prefs
      await _loadUserFromSharedPrefs();
      return true; // User data exists
    } else {
      return false; // User data does not exist
    }
  }

  Future<bool> loadUserFromFirestoreAndStoreLocally() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      log(userId);

      // Reference to the user's document in Firestore
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      // Fetch user data from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await userDoc.get();
      log('second here');
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data()!;
        log(json.encode(userData));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("user", json.encode(userData));
        await prefs.setBool('isUserRegistered', true);

        MyUser user = MyUser.fromMap(userData);
        user.tracker.calculateWaterGoal(user.data.weight!);

        log(user.toString());
        return true; // User data loaded successfully
      } else {
        return false; // User document does not exist
      }
    } catch (e) {
      log('Error loading user from Firestore: $e');
      return false; // Error occurred
    }
  }

  // Load user from shared prefs
  Future<void> _loadUserFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyUser user = MyUser.fromMap(json.decode(prefs.getString('user')!));
    log("User loaded from shared prefs");
  }

  Future<void> saveUserToFirestore(MyUser user) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('users');
      String userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

      await userCollection.doc(userId).set(user.toMap());

      log('User saved to Firestore successfully.');
    } catch (e) {
      log('Failed to save user to Firestore: $e');
    }
  }

  Future<void> saveUserToSharedPrefs(MyUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user.toMap()));
  }

}
