class WeatherStates {}

class WeatherLoadedState extends WeatherStates {}

class NoWeatherDataState extends WeatherStates {}

class WeatherFailureState extends WeatherStates {
  String message;
  WeatherFailureState({required this.message});
}
