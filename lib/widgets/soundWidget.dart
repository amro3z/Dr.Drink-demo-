import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_drink/logic/notifications.dart';
import 'package:dr_drink/values/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logic/user.dart';

class SoundSettingsContent extends StatefulWidget {
  const SoundSettingsContent({super.key});

  @override
  _SoundSettingsContentState createState() => _SoundSettingsContentState();
}

class _SoundSettingsContentState extends State<SoundSettingsContent> {
  final MyUser _user = MyUser.instance;
  String selectedSound = ''; // Holds the currently selected sound

  @override
  void initState() {
    super.initState();
    // Load the current sound setting from the notification service or user's profile
    selectedSound = _user.profile.notificationSound;
  }

  Future<void> _saveUserToSharedPrefs(MyUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user.toMap()));
  }

  Future<void> _saveUserToFirestore(MyUser user) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('users');
      String userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

      await userCollection.doc(userId).set(user.toMap());

      log('User saved to Firestore successfully.');
    } catch (e) {
      log('Failed to save user to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Notification Sound',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Sound effect'),
            value: selectedSound.isNotEmpty,
            activeColor: MyColor.blue,
            onChanged: (bool enabled) {
              setState(() {
                selectedSound = enabled ? _user.profile.notificationSound : '';
              });
            },
          ),
          _buildRadioTile('Default', ''),
          _buildRadioTile('Water drop', 'water_drop'),
          _buildRadioTile('Water bubble', 'water_bubble'),
          _buildRadioTile('Water pouring', 'water_pouring'),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                LocalNotificationService.setNotificationSound(selectedSound);
                _user.profile.notificationSound = selectedSound;
                LocalNotificationService.cancelAllNotifications();
                LocalNotificationService.showRepeatedNotification();
                _saveUserToSharedPrefs(_user);
                _saveUserToFirestore(_user);
                Navigator.pop(context); // Close the dialog or settings page
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: MyColor.blue,
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create a reusable RadioListTile
  Widget _buildRadioTile(String title, String value) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: selectedSound,
      activeColor: MyColor.blue,
      onChanged: (String? value) {
        setState(() {
          selectedSound = value!;
        });
      },
    );
  }
}
