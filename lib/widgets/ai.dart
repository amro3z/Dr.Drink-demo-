import 'dart:developer';
import 'package:dr_drink/cubits/weather_cubit/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiWidget extends StatefulWidget {
  AiWidget({super.key});

  @override
  _AiWidgetState createState() => _AiWidgetState();
}

class _AiWidgetState extends State<AiWidget> {
  final String apiKey =
      'AIzaSyDNXDDEWLa-v6K1IEklBS1YH2gzppBM7j4'; // ضع هنا مفتاح API الخاص بك
  List<String> tips = []; // قائمة لتخزين النصائح

  // دالة لجلب النصائح
  Future<void> fetchTips() async {
    final weather = BlocProvider.of<WeatherCubit>(context).weather;
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      final prompt =
          'Give me 5 tips for drinking water in ${weather.condition} wather';
      final response = await model.generateContent([Content.text(prompt)]);

      // نفترض أن النصائح تأتي بشكل منفصل ومفصولة بخط جديد
      List<String> fetchedTips =
          response.text?.split('\n') ?? ['No tips available'];

      setState(() {
        tips = fetchedTips; // تخزين النصائح في القائمة
      });
    } catch (e) {
      log('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Tips'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: fetchTips, // استدعاء الدالة لجلب النصائح
            child: const Text("Get Productivity Tips"),
          ),
          Expanded(
            child: tips.isEmpty
                ? const Center(child: Text('No tips available.'))
                : ListView.builder(
                    itemCount: tips.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            tips[index], // عرض النصيحة في الكارت
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
