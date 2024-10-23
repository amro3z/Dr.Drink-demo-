import 'package:dr_drink/values/color.dart';
import 'package:dr_drink/values/color.dart';
import 'package:dr_drink/values/color.dart';
import 'package:dr_drink/values/color.dart';
import 'package:dr_drink/values/color.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';

class SoundSettingsContent extends StatefulWidget {
  const SoundSettingsContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SoundSettingsContentState createState() => _SoundSettingsContentState();
}

class _SoundSettingsContentState extends State<SoundSettingsContent> {
  String selectedSound = 'Default';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Notifications Sound',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: Text('Sound effect'),
            value: true,
            activeColor: MyColor.blue, // Change active switch color to blue
            onChanged: (bool value1) {
              setState(() {
                // Update switch state here
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Default'),
            value: '',
            groupValue: selectedSound,
            activeColor: MyColor.blue, // Change radio button color to blue
            onChanged: (String? value) {
              setState(() {
                selectedSound = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Water drop'),
            value: 'water-drop',
            groupValue: selectedSound,
            activeColor: MyColor.blue, // Change radio button color to blue
            onChanged: (String? value) {
              setState(() {
                selectedSound = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Water bubble'),
            value: 'water-bubble',
            groupValue: selectedSound,
            activeColor: MyColor.blue, // Change radio button color to blue
            onChanged: (String? value) {
              setState(() {
                selectedSound = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Water pouring'),
            value: 'water-pouring',
            groupValue: selectedSound,
            activeColor: MyColor.blue, // Change radio button color to blue
            onChanged: (String? value) {
              setState(() {
                selectedSound = value!;
              });
            },
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight, // Align the button to the right
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: MyColor.blue, // Button background color
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.white, // Button text color to white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
