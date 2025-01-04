import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  WeatherService(this.apiKey);

  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  Future<Weather> getWeather() async {
    Position position = await Geolocator.getCurrentPosition();
    final response = await http.get(Uri.parse(
        '$BASE_URL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current location
    Position position = await Geolocator.getCurrentPosition();

    // convert the location into a list of placemark
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // exact the city name from the first placemark
    String? city = placemarks[0].locality;

    return city ?? '';
  }
}
