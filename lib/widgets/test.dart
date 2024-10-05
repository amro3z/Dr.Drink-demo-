import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/weather_cubit/weather_cubit.dart';
import '../cubits/weather_cubit/weather_states.dart';
import 'ai.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherCubit, WeatherStates>(
        builder: (context, state) {
          if (state is NoWeatherDataState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoadedState) {
            var weather = BlocProvider.of<WeatherCubit>(context).weather;
            return Center(
              child: Column(
                children: [
                  Text("Weather condition: ${weather.condition}"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AiWidget()));
                      },
                      child: Text("go"))
                ],
              ),
            );
          } else if (state is WeatherFailureState) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
