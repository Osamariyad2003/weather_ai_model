import 'package:weather_tennis_ai_model/features/weather/domain/use_case/get_forcast.dart';

import '../../../data/model/weather.dart';

abstract class WeatherStates{}

class WeatherIntitalState extends WeatherStates{}

class ForacstGetLoadingState extends WeatherStates{}
class ForacstGetSuccessState extends WeatherStates{
  WeatherForecast? weatherForecast;
 ForacstGetSuccessState(this.weatherForecast);
}
class ForacstGetErrorState extends WeatherStates{
  final String error;
  ForacstGetErrorState(this.error);
}
class ForcastDayChange extends WeatherStates{}
class GetPredictionLoading extends WeatherStates{}
class GetPredictionSuccess extends WeatherStates{}
class GetPredictionError extends WeatherStates{
  final String error;
  GetPredictionError(this.error);
}
class GetChartSuccess extends WeatherStates{}

class WeatherBottomNavState extends WeatherStates{}
class GetCurrentCityState extends WeatherStates{}

class MapZoomIn extends WeatherStates{}