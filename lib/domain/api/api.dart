import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nweather_app/domain/models/weather_model.dart';
import '../models/coord.dart';

abstract class Api {
  static final apiKey = dotenv.get('API_KEY');

  static Future<Coord> getCoords({String cityName = 'Tashkent'}) async {
    final dio = Dio();
    final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&lang=ru');

    try {
      final coords = Coord.fromJson(response.data);
      return coords;
    } catch (e) {
      final coords = Coord.fromJson(response.data);
      return coords;
    }
  }

  static Future<WeatherData?> getWeather(Coord? coord) async {
    if (coord != null) {
      final dio = Dio();
      final lat = coord.lat.toString();
      final lon = coord.lon.toString();
      final response = await dio.get(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,minutely&appid=$apiKey&lang=ru');
      final weatherData = WeatherData.fromJson(response.data);
      return weatherData;
    }
    return null;
  }
}



// Ссылка для получения координат
//https://api.openweathermap.org/data/2.5/weather?q=London&appid=276df4f14ffa9f273f22ce66c1f604b8



// Ссылка для получения погоды
//https://api.openweathermap.org/data/2.5/onecall?lat=55.7522&lon=37.6156&exclude=hourly,minutely&appid=afdf6f8e1d0cee17539d96e8886655b6