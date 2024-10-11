import 'package:intl/intl.dart';

class WeatherForecast {
  final List<WeatherModel>? forecastDays;

  WeatherForecast({
    required this.forecastDays,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    var list = json['forecast']['forecastday'] as List;
    List<WeatherModel> forecastList =
    list.map((dayJson) => WeatherModel.fromJson(dayJson)).toList();

    return WeatherForecast(forecastDays: forecastList);
  }

  WeatherForecast toEntity() {
    return WeatherForecast(
      forecastDays: forecastDays?.map((model) =>model.toEntity()).toList(),
    );
  }
}




class WeatherModel {
  final double tempC;
  final int humidity;
  final double windKph;
  final String sunrise;
  final String conditionText;
  final String date;
  final String conditionIcon;
  final String dayname;

  WeatherModel({
    required this.tempC,
    required this.humidity,
    required this.windKph,
    required this.sunrise,
    required this.conditionText,
    required this.date,
    required this.conditionIcon,
    required this.dayname,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    String fullDate = json['date'] ?? '';
    String dayname = fullDate.isNotEmpty
        ? DateFormat('EEEE').format(DateTime.parse(fullDate))
        : 'Unknown';
    String name = dayname.isNotEmpty
        ? dayname.substring(0, 3)
        : 'N/A';

    String day = fullDate.isNotEmpty
        ? fullDate.substring(fullDate.length - 2)
        : '01';

    return WeatherModel(
      tempC: (json['day']?['avgtemp_c'] ?? 0).toDouble(),
      humidity: json['day']?['avghumidity'] ?? 0,
      windKph: (json['day']?['maxwind_kph'] ?? 0).toDouble(),
      sunrise: json['astro']?['sunrise'] ?? 'N/A',
      conditionText: json['day']?['condition']?['text'] ?? 'Unknown',
      conditionIcon: json['day']?['condition']?['icon'] ?? '',
      date: day,
      dayname: name,
    );
  }

  WeatherModel toEntity() {
    return WeatherModel(
      tempC: tempC,
      humidity: humidity,
      windKph: windKph,
      sunrise: sunrise,
      conditionText: conditionText,
      date: date,
      conditionIcon: conditionIcon,
      dayname: dayname,
    );
  }
}

