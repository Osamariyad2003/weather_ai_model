import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:weather_tennis_ai_model/core/components/constant.dart';
import 'package:weather_tennis_ai_model/core/network/dio_helper.dart';

import '../model/weather.dart';
import 'package:http/http.dart' as http;

abstract class BaseWeatherRemoteDataSource {
  Future<WeatherForecast> getForcastWeather(String cityName);
  Future<void> getPrediction(int outlook, int temperature, int humidity);
}

class WeatherRemoteDataImp extends BaseWeatherRemoteDataSource {
  @override
  Future<WeatherForecast> getForcastWeather(String cityName) async {
    try {
      final response = await DioHelper.getData(
        url: Urls.weather_baseUrl+Urls.foracst,
        query: {
          "q":cityName,
          "days":7,
          'key': Urls.weather_apiKey
        }
      );

      if (response != null && response.data != null) {
        print(response.data);
        return WeatherForecast.fromJson(response.data);
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (error) {
      print("Error fetching weather data: $error");
      throw Exception("Error fetching weather data");
    }
  }

  @override
  Future<List<FlSpot>> getPrediction(int outlook, int temperature, int humidity) async {
    try {
      List<FlSpot> predictionSpots = [];

      final response = await http.post(
        Uri.parse('http://192.168.1.78:5001/predict'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'outlook': outlook,
          'temperature': temperature,
          'humidity': humidity,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        List<double> predictions = List<double>.from(result['predictions']);
        predictionSpots = predictions
            .asMap()
            .entries
            .map((e) => FlSpot(e.key.toDouble(), e.value))
            .toList();

         return predictionSpots;

      } else {
        throw Exception('Failed to get prediction');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }



}
