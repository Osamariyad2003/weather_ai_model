import 'package:weather_tennis_ai_model/features/weather/data/model/weather.dart';


import '../data_source/weather_data.dart';

class WeatherRepositoryImpl  {

  final WeatherRemoteDataImp weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future <WeatherForecast> getForcastWeather(String cityName,Date) async {
      final result = await weatherRemoteDataSource.getForcastWeather(cityName,Date);
      return result;

  }
}