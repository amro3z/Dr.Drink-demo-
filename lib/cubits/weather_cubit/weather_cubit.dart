// flutter pub add flutter_bloc
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dr_drink/service/WeatherModel.dart';
import 'package:dr_drink/service/WeatherService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_states.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(NoWeatherDataState());
  late Weathermodel weather;
  void getWeather() async {
    try {
      weather = await Weatherservice(Dio())
          .getWeather(city: 'cairo', apikey: 'f6a8fc2762434e16820173557240310');
      log(weather.condition);
      emit(WeatherLoadedState());
    } catch (e) {
      log(e.toString());
      emit(WeatherFailureState(message: e.toString()));
    }
  }
}
