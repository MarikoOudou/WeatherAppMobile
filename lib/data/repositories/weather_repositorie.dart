import 'package:flutter_application_1/data/models/weather_model.dart';
import 'package:flutter_application_1/data/network_service.dart';

class WeatherRepositorie {
  final NetworkService networkService = NetworkService();

  Future<WeatherModel> weatherSearchLocation(String location) async {
    print("valeur repo !! $location");

    final WeatherModel weatherLocation = WeatherModel.fromJson(
        await networkService.requestHttpGetData(location));
    print(weatherLocation);
    return weatherLocation;
  }
}
