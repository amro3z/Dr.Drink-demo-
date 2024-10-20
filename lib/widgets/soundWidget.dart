
import 'package:flutter/material.dart';

class SoundSettingsContent extends StatefulWidget {
  const SoundSettingsContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SoundSettingsContentState createState() => _SoundSettingsContentState();
}

class _SoundSettingsContentState extends State<SoundSettingsContent> {
  String selectedSound = 'Water drop 2';
  double volume = 0.5;
  bool vibrationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Sounds & Vibration',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: Text('Sound effect'),
            value: vibrationEnabled,
            onChanged: (bool value1) {
              setState(() {
                vibrationEnabled = value1;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Water 1'),
            value: 'Water drop 1',
            groupValue: selectedSound,
            onChanged: (String? value) {
              setState(() {
                selectedSound = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Water 2'),
            value: 'Water drop 2',
            groupValue: selectedSound,
            onChanged: (String? value) {
              setState(() {
                selectedSound = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Water 3'),
            value: 'Water 3',
            groupValue: selectedSound,
            onChanged: (String? value) {
              setState(() {
                selectedSound = value!;
              });
            },
          ),
          Slider(
            value: volume,
            onChanged: (double value) {
              setState(() {
                volume = value;
              });
            },
            min: 0,
            max: 1,
          ),

          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}