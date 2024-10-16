import '../../data/model/weather.dart';
import '../../data/repository/weather.dart';

class GetForecastWeatherUseCase {
  final WeatherRepositoryImpl weatherRepository;

  GetForecastWeatherUseCase(this.weatherRepository);

  Future<WeatherForecast> execute(String cityName) async {
    return await weatherRepository.getForcastWeather(cityName);
  }
}
