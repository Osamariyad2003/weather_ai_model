import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_tennis_ai_model/core/components/routing.dart';
import 'package:weather_tennis_ai_model/features/weather/data/model/weather.dart';
import 'package:weather_tennis_ai_model/features/weather/presentition/widgets/day.dart';

import '../../../../core/components/error_dialog.dart';
import '../../../../core/utilies/main_colors.dart';
import '../controller/bloc/weather_cubit.dart';
import '../controller/states/wether_states.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key, required this.cityName}) : super(key: key);
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (BuildContext context, WeatherStates state) {},
      builder: (context, state) {
        if (state is ForacstGetLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ForacstGetSuccessState) {
          final weatherData = state.weatherForecast;
          final forecastDays = weatherData?.forecastDays;
          int selectedIndex = 0; // Variable to store selected index

          return ConditionalBuilder(
            condition: forecastDays != null,
            builder: (context) => SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(color: MainColors.mainColor),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: forecastDays!.length,
                          itemBuilder: (context, index) {
                            bool isSelected = selectedIndex == index;
                            return InkWell(
                              onTap: () {
                                selectedIndex = index;
                                context.read<WeatherCubit>().getForecastWeather(context.read<WeatherCubit>().currentAddress,forecastDays[index].date);
                              },
                              child: buildDateItem(
                                forecastDays[index].date,
                                forecastDays[index].dayname,
                                isSelected: isSelected,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildWeatherHeader(forecastDays[selectedIndex]),
                      SizedBox(height: 20),
                      _buildWeatherDetails(forecastDays[selectedIndex]),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => CircularProgressIndicator(),
          );
        } else if (state is ForacstGetErrorState) {
          return Center(
            child: ShowDialogError(title: 'Error', subTitle: state.error),
          );
        } else {
          return Center(child: Text("Please wait..."));
        }
      },
    );
  }

  // Method for date item with selection handling
  Widget buildDateItem(String day, String label, {bool isSelected = false}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white70),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  // Weather header (temperature and condition)
  Widget _buildWeatherHeader(WeatherModel weather) {
    return Center(
      child: Column(
        children: [
          Image.network(
            "https:${weather.conditionIcon}", // Weather condition icon
            width: 80,
            height: 80,
          ),
          Text(
            '${weather.tempC.round()}°C',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            weather.conditionText,
            style: TextStyle(fontSize: 24, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Customized weather details section
  Widget _buildWeatherDetails(WeatherModel weather) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildDetailItem('${weather.tempC}°', 'Temp', Icons.thermostat),
        buildDetailItem('${weather.humidity}%', 'Humidity', Icons.water_drop),
        buildDetailItem('${weather.windKph} kph', 'Wind', Icons.wind_power),
      ],
    );
  }

  // Helper method for weather detail items
  Widget buildDetailItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }
}




