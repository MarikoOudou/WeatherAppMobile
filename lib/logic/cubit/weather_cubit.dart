import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/data/models/weather_model.dart';
import 'package:flutter_application_1/data/repositories/weather_repositorie.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepositorie weatherRepositorie = WeatherRepositorie();
  // final String location;

  WeatherCubit() : super(WeatherInitial());

  fetchWeather(String location) {
    emit(WeatherLoading());
    weatherRepositorie.weatherSearchLocation(location).then((value) => {
          if (value == null || value.location == null)
            {emit(WeatherErrorData())}
          else if (value != null)
            {emit(WeatherLoaded(weatherModel: value))}
        });
  }
}
