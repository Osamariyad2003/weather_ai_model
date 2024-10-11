import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_tennis_ai_model/features/weather/data/model/weather.dart';
import 'package:weather_tennis_ai_model/features/weather/domain/use_case/get_forcast.dart';
import 'package:weather_tennis_ai_model/features/weather/presentition/screens/fav.dart';
import 'package:weather_tennis_ai_model/features/weather/presentition/screens/location.dart';
import 'package:weather_tennis_ai_model/features/weather/presentition/screens/profile.dart';
import '../../../data/repository/weather.dart';
import '../states/wether_states.dart';
enum SelectedTab{home,fav,profile,charts}

class WeatherCubit extends Cubit<WeatherStates>{
  final WeatherRepositoryImpl weatherRepository;

  WeatherCubit(this.weatherRepository,this.getForecastWeatherUseCase):super(WeatherIntitalState());
  static WeatherCubit get(context) => BlocProvider.of(context);

   WeatherForecast? weatherForecast;
   GetForecastWeatherUseCase getForecastWeatherUseCase;
  Position? currentPosition;
  late String currentAddress;
  late GoogleMapController mapController;
  double zoomLevel = 8.0;
  var selectedTab = SelectedTab.home;
  int currentindex =0;
  LatLng initialPosition = LatLng(45.4215, -75.6972);
  List<Widget> bottomScreens = [
    LocationScreen(),
    FavScreen(),
    ProfileScreen(),
    ChartsScreen(),
    //ReminderPage()
  ];

  void zoomIn() {
      zoomLevel += 1; // Increase zoom level
      mapController.animateCamera(CameraUpdate.zoomTo(zoomLevel)); // Apply zoom
    emit(MapZoomIn());
  }
 void  changeBottomNavBar(int index) {
   selectedTab = SelectedTab.values[index];
   currentindex=index;
   emit(WeatherBottomNavState());
  }


  Future<void> getForecastWeather(  String cityname,Date) async {
    emit(ForacstGetLoadingState());
    try {

         final forcast = await getForecastWeatherUseCase.execute(cityname,Date);

      emit(ForacstGetSuccessState(forcast)); // Emit success with the data
    } catch (error) {
      emit(ForacstGetErrorState(error.toString())); // Emit error if something goes wrong
    }
  }
  Future<String> getCurrentCity() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return 'Location services are disabled';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return 'Location permissions are denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return 'Location permissions are permanently denied';
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);


      List<Placemark> placemark = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      initialPosition = LatLng(position.latitude, position.longitude);

      String? cityName = placemark[0].locality;
      currentAddress = cityName??"";
      return cityName ?? "";
    } catch (e) {
      print('Location error: $e');
      return 'Error getting location: $e';
    }
  }


}