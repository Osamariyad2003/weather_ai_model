import 'package:fl_chart/fl_chart.dart';
import 'package:weather_tennis_ai_model/features/weather/data/model/weather.dart';


import '../data_source/weather_data.dart';

class WeatherRepositoryImpl  {

  final WeatherRemoteDataImp weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future <WeatherForecast> getForcastWeather(String cityName) async {
      final result = await weatherRemoteDataSource.getForcastWeather(cityName);
      return result;

  }
  @override
  Future<List<FlSpot>> getPrediction(int outlook, int temperature, int humidity)async{
    final result = await weatherRemoteDataSource.getPrediction(outlook, temperature, humidity);
    return result;
  }
}