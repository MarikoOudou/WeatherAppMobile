// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherErrorData extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weatherModel;

  WeatherLoaded({required this.weatherModel});
}

class WeatherLocationSend extends WeatherState {
  final String location;

  WeatherLocationSend({required this.location});
}
