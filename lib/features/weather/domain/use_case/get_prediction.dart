import 'package:fl_chart/fl_chart.dart';

import '../../data/repository/weather.dart';

class GetPredictionWeatherUseCase {
  final WeatherRepositoryImpl weatherRepository;

  GetPredictionWeatherUseCase(this.weatherRepository);

  Future<List<FlSpot>> execute(int outlook, int temperature, int humidity) async {
    return await weatherRepository.getPrediction(outlook,temperature,humidity);
  }
}