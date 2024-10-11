import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_tennis_ai_model/core/components/routing.dart';
import 'package:weather_tennis_ai_model/core/utilies/main_colors.dart';
import 'package:weather_tennis_ai_model/features/weather/presentition/controller/bloc/weather_cubit.dart';
import 'package:weather_tennis_ai_model/features/weather/presentition/controller/states/wether_states.dart';
import 'package:weather_tennis_ai_model/features/weather/presentition/screens/weather.dart';
class LocationScreen extends StatelessWidget {
  TextEditingController locationcotroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit,WeatherStates>(
      listener: (BuildContext context, WeatherStates state)async {
        if(state is WeatherIntitalState){
          WeatherCubit.get(context).getCurrentCity();
        }
        // if(state is GetCurrentCityState){
        //   locationcotroller.text =await  WeatherCubit.get(context).getCurrentCity();
        // }
      },
      builder: (BuildContext context, WeatherStates state) {


        var cubit = WeatherCubit.get(context);
        return Padding(
          padding:  EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Map widget
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: cubit.initialPosition,
                          zoom: cubit.zoomLevel,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          cubit.mapController = controller;
                        },
                        mapType: MapType.hybrid,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: WeatherCubit.get(context).zoomIn, // Call the zoom in method
                    style: ElevatedButton.styleFrom(


                      backgroundColor: Colors.black, // Button color
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Extend",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),

              SizedBox(height: 10),

              TextField(
                controller: locationcotroller,
                onTap: ()async{
                 locationcotroller.text= await cubit.getCurrentCity();
                },
                style: TextStyle(color:MainColors.mainColor ),
                decoration: InputDecoration(
                  prefixIcon:IconButton(onPressed: (){}, icon: Icon(Icons.pin_drop_outlined)) ,

                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Destination",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

              ),
              SizedBox(height: 20),

              // Search Button
              ElevatedButton(
                onPressed: () async{
                  DateTime now = DateTime.now();

                  // Format the date as YYYY-MM-DD
                  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                 await cubit.getForecastWeather( locationcotroller.text,formattedDate).then((value){
                   if(cubit.getForecastWeatherUseCase != null){
                     cubit.bottomScreens[0] = WeatherScreen(cityName: locationcotroller.text,);


                   }else{
                     print("Error");
                   }
                 });



                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
