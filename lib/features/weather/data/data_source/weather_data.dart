import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:weather_tennis_ai_model/core/components/constant.dart';
import 'package:weather_tennis_ai_model/core/network/dio_helper.dart';

import '../model/weather.dart';
import 'package:dio/dio.dart';

abstract class BaseWeatherRemoteDataSource {
  Future<WeatherForecast> getForcastWeather(String cityName,Date);
}

class WeatherRemoteDataImp extends BaseWeatherRemoteDataSource {
  @override
  Future<WeatherForecast> getForcastWeather(String cityName,Date) async {
    try {
      final response = await DioHelper.getData(
        url: Urls.weather_baseUrl+Urls.foracst,
        query: {
          "q":cityName,
          "days":7,
           "dt":Date,
          'key': Urls.weather_apiKey
        }
      );

      if (response != null && response.data != null) {
        return WeatherForecast.fromJson(response.data);
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (error) {
      print("Error fetching weather data: $error");
      throw Exception("Error fetching weather data");
    }
  }
}
