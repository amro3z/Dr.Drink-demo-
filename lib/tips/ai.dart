import 'dart:developer';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../cubits/weather_cubit/weather_cubit.dart'; // استورد WeatherCubit هنا

class TipService {
  final WeatherCubit weatherCubit;

  TipService({required this.weatherCubit}); // بنمرر الـ cubit كـ باراميتر

  // دالة لجلب النصائح من API
  Future<List<String>> fetchTips() async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: 'AIzaSyDNXDDEWLa-v6K1IEklBS1YH2gzppBM7j4',
      );

      // استخدام weather.condition بعد التأكد من أنها ليست null
      final prompt =
          'Give me 1 tip for drinking water. The weather is ${weatherCubit.weather.condition}, give a suitable tip without any stars in text';

      final response = await model.generateContent([Content.text(prompt)]);

      // نفترض أن النصائح تأتي بشكل منفصل ومفصولة بخط جديد
      List<String> fetchedTips =
          response.text?.split('\n') ?? ['No tips available'];

      return fetchedTips;
    } catch (e) {
      log('Error fetching tips: $e'); // عرض مزيد من التفاصيل عن الخطأ
      return ['Error fetching tips'];
    }
  }
}
