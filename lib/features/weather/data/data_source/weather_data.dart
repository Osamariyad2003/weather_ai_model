import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:weather_tennis_ai_model/core/components/constant.dart';
import 'package:weather_tennis_ai_model/core/network/dio_helper.dart';

import '../model/weather.dart';
import 'package:http/http.dart' as http;

abstract class BaseWeatherRemoteDataSource {
  Future<WeatherForecast> getForcastWeather(String cityName);
  Future<List<int>> getPrediction(List<int> features);
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
  Future<List<int>> getPrediction(List<int> features) async {
    final url = Uri.parse('http://10.0.2.2:5001/predict');

    // Create the POST request body
    Map<String, dynamic> body = {
      'features': features,
    };

    // Send the POST request
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      // Decode and ensure the response is properly cast to List<int>
      final dynamic prediction = json.decode(response.body)['prediction'];

      // Debugging: print the raw prediction data
      print('Raw prediction: $prediction');

      // Convert the dynamic list to List<int> to match the expected return type
      List<int> predictionData = List<int>.from(prediction.map((item) => item as int));

      return predictionData;
    } else {
      print('Failed to get prediction');
      return [0]; // Return a default value in case of failure
    }
  }

}
