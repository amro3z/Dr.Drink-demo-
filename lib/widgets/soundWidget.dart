import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_drink/logic/notifications.dart';
import 'package:dr_drink/values/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logic/storage.dart';
import '../logic/user.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundSettingsContent extends StatefulWidget {
  const SoundSettingsContent({super.key});

  @override
  SoundSettingsContentState createState() => SoundSettingsContentState();
}

class SoundSettingsContentState extends State<SoundSettingsContent> {
  final MyUser _user = MyUser.instance;
  Storage _storage = Storage();
  String _selectedSound = '';
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Load the current sound setting from the notification service or user's profile
    _selectedSound = _user.profile.notificationSound;
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
          _buildRadioTile('Default', ''),
          _buildRadioTile('Water drop', 'water_drop'),
          _buildRadioTile('Water bubble', 'water_bubble'),
          _buildRadioTile('Water pouring', 'water_pouring'),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                LocalNotificationService.setNotificationSound(_selectedSound);
                _user.profile.notificationSound = _selectedSound;

                LocalNotificationService.schedule();
                _storage.saveUser(_user); // Save the updated user profile
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
      groupValue: _selectedSound,
      activeColor: MyColor.blue,
      onChanged: (String? value) {
        setState(() {
          _selectedSound = value!;
          _playSound(_selectedSound); // Play the selected sound
        });
      },
    );
  }

  // Function to play sound
  Future<void> _playSound(String sound) async {
    // You might need to change the path based on your assets location
    String assetPath = 'sounds/$sound.ogg'; // Ensure sound files are placed in this directory
    await _audioPlayer.setSource(AssetSource(assetPath));
    await _audioPlayer.resume(); // Play the sound
  }
}


//
//
// import 'package:flutter/material.dart';
//
// import '../values/color.dart';
//
// class Reminder extends StatefulWidget {
//   const Reminder({super.key});
//
//   @override
//   State<Reminder> createState() => _ReminderState();
// }
//
// class _ReminderState extends State<Reminder> {
//   int selectedHour = 0;
//   int selectedMinute = 10; // Default to 30 if hour is 0
//   int pickedHour = 0;
//   int pickedMinute = 10;
//
//   Future<void> _showIntervalPicker(BuildContext context) async {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setModalState) {
//             return Container(
//               height: 300,
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   const Text(
//                     'Select Interval',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Hour Picker
//                         Expanded(
//                           child: ListWheelScrollView.useDelegate(
//                             itemExtent: 50,
//                             perspective: 0.005,
//                             physics: const FixedExtentScrollPhysics(),
//                             onSelectedItemChanged: (value) {
//                               setModalState(() {
//                                 pickedHour = value;
//                                 if (pickedHour == 0 && pickedMinute < 10) {
//                                   pickedMinute = 10;
//                                 }
//                               });
//                             },
//                             childDelegate: ListWheelChildBuilderDelegate(
//                               builder: (context, index) {
//                                 return Center(
//                                   child: Text(
//                                     '$index hour',
//                                     style: const TextStyle(fontSize: 20),
//                                   ),
//                                 );
//                               },
//                               childCount: 4, // 0 to 3 hours
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         // Minute Picker
//                         Expanded(
//                           child: ListWheelScrollView.useDelegate(
//                             itemExtent: 50,
//                             perspective: 0.005,
//                             physics: const FixedExtentScrollPhysics(),
//                             onSelectedItemChanged: (value) {
//                               setModalState(() {
//                                 pickedMinute = pickedHour == 0
//                                     ? value * 10
//                                     : value * 10;
//                               });
//                             },
//                             childDelegate: ListWheelChildBuilderDelegate(
//                               builder: (context, index) {
//                                 int minuteValue = pickedHour == 0
//                                     ? ++index * 10
//                                     : index * 10;
//                                 return Center(
//                                   child: Text(
//                                     '$minuteValue min',
//                                     style: const TextStyle(fontSize: 20),
//                                   ),
//                                 );
//                               },
//                               childCount: pickedHour == 0 ? 5 : 6,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   // Save Button
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         selectedHour = pickedHour;
//                         selectedMinute = pickedMinute;
//                         Navigator.pop(context); // Close the sheet
//                         setState(() {}); // Trigger rebuild to display updated interval
//                       },
//                       style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                       backgroundColor: MyColor.blue,
//                       ),
//                       child: const Text(
//                       'Save',
//                       style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xfff7f7ff),
//         body: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   const Text(
//                     "Reminder",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Interval Row
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: GestureDetector(
//                 onTap: () => _showIntervalPicker(context),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Interval',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       '$selectedHour hour(s) $selectedMinute min(s)',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
