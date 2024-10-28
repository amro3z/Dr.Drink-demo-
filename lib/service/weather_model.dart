// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherModel {
  final String cityName;
  final String condition;
  WeatherModel({
    required this.cityName,
    required this.condition,
  });
  factory WeatherModel.fromJson(json) {
    return WeatherModel(
      cityName: json['location']['name'],
      condition: json['forecast']['forecastday'][0]['day']['condition']['text'],
    );
  }
}
