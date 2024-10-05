// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weathermodel {
  final String cityname;
  final String condition;
  Weathermodel({
    required this.cityname,
    required this.condition,
  });
  factory Weathermodel.fromJson(json) {
    return Weathermodel(
      cityname: json['location']['name'],
      condition: json['forecast']['forecastday'][0]['day']['condition']['text'],
    );
  }
}
