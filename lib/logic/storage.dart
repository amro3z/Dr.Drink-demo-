import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dr_drink/logic/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'account.dart';
import 'history.dart';

class Storage {
  Future<bool> loadUserFromFirestoreAndStoreLocally() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      log('User ID: $userId');

      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        final userData = snapshot.data()!;
        log(json.encode(userData));

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("user", json.encode(userData));
        await prefs.setBool('isUserRegistered', true);

        MyUser user = MyUser.fromMap(userData);
        user.tracker.calculateWaterGoal(user.data.weight!);
        log(user.toString());

        return true;
      }
    } catch (e) {
      log('Error loading user from Firestore: $e');
    }
    return false;
  }

  Future<void> _saveUserToFirestore(MyUser user) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('users');
      String userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous'; // Get the user ID if available

      await userCollection.doc(userId).set(user.toMap());

      log('User saved to Firestore successfully.');
    } catch (e) {
      log('Failed to save user to Firestore: $e');
    }
  }

  Future<bool> loadUserFromSharedPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('isUserRegistered') == true) {
        final userData = json.decode(prefs.getString('user')!);
        MyUser user = MyUser.fromMap(userData);
        user.tracker.calculateWaterGoal(user.data.weight!);
        log('User loaded from SharedPreferences: ${user.toString()}');
        return true;
      }
    } catch (e) {
      log('Error loading user from SharedPreferences: $e');
    }
    return false;
  }

  Future<void> _saveUserToSharedPrefs(MyUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user.toMap()));
    await prefs.setBool('isUserRegistered', true);
  }

  Future<Account?> loadAccountFromSharedPrefs() async {
    Account? account;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountJson = prefs.getString('account');
    if (accountJson != null) {
      account = Account.fromMap(json.decode(accountJson));
    }
    return account;
  }

  Future<void> saveAccount(String name, String email) async {
    Account account = Account(email: email, userName: name);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("account", json.encode(account.toMap()));
  }

  void saveUser(MyUser user){
    _saveUserToSharedPrefs(user);
    _saveUserToFirestore(user);
  }
}
