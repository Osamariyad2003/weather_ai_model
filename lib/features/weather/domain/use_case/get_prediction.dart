import 'package:fl_chart/fl_chart.dart';

import '../../data/repository/weather.dart';

class GetPredictionWeatherUseCase {
  final WeatherRepositoryImpl weatherRepository;

  GetPredictionWeatherUseCase(this.weatherRepository);

  Future<List<int>> execute(List<int> features) async {
    return await weatherRepository.getPrediction( features);
  }
}