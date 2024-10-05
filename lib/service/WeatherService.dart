import 'package:dio/dio.dart';
import 'package:dr_drink/service/WeatherModel.dart';

class Weatherservice {
  Weatherservice(Dio dio);

  Future<Weathermodel> getWeather(
      {required String city, required String apikey}) async {
    try {
      Response response = await Dio().get(
          'http://api.weatherapi.com/v1/forecast.json?key=${apikey}&q=${city.toLowerCase()}&days=1&aqi=no&alerts=no');
      return Weathermodel.fromJson(response.data);
    } on DioException catch (e) {
      String error = e.response?.data['error']['message'] ??
          'Error  Server, try again later';
      throw Exception(error);
    } catch (e) {
      throw Exception('Error , try again later');
    }
  }
}
