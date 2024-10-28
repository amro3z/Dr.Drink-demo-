import 'package:dio/dio.dart';
import 'package:dr_drink/service/weather_model.dart';

class WeatherService {
  WeatherService(Dio dio);

  Future<WeatherModel> getWeather(
      {required String city, required String apikey}) async {
    try {
      Response response = await Dio().get(
          'http://api.weatherapi.com/v1/forecast.json?key=$apikey&q=${city.toLowerCase()}&days=1&aqi=no&alerts=no');
      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      String error = e.response?.data['error']['message'] ??
          'Error  Server, try again later';
      throw Exception(error);
    } catch (e) {
      throw Exception('Error , try again later');
    }
  }
}
