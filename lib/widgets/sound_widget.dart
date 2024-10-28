import 'package:dr_drink/logic/notifications.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
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
  final Storage _storage = Storage();
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