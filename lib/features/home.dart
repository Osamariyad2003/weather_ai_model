import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_tennis_ai_model/core/utilies/main_colors.dart';
import 'package:weather_tennis_ai_model/features/auth/data/model/user_model.dart';
import 'package:weather_tennis_ai_model/features/weather/presentition/controller/bloc/weather_cubit.dart';
import 'package:weather_tennis_ai_model/features/weather/presentition/controller/states/wether_states.dart';


class HomeScreen extends StatelessWidget {
  final String name;
  HomeScreen(this.name);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit,WeatherStates>(listener: (
        BuildContext context, WeatherStates state) {  },
      builder: (BuildContext context, WeatherStates state) {
      var cubit = WeatherCubit.get(context);
           return Scaffold(
             backgroundColor:  MainColors.mainColor, // Dark background
             appBar: AppBar(
               toolbarHeight: 100,
               backgroundColor: Colors.transparent,
               elevation: 0,
               title: Padding(
                 padding: EdgeInsets.only(top: 20.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       "Hello",
                       style: TextStyle(
                         color: Colors.blue,
                         fontSize: 24,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     Text(
                       "$name",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 18,
                       ),
                     ),
                   ],
                 ),
               ),
               actions: [
                 Padding(
                   padding: EdgeInsets.only(top: 20.0,right: 20),
                   child: Icon(Icons.menu, color: Colors.white),
                 ),
               ],
             ),
             body:  IndexedStack(
               index: cubit.currentindex,
               children: cubit.bottomScreens,
             ),
             bottomNavigationBar: Padding(
               padding:  EdgeInsets.only(bottom: 15,right: 20,left: 20),

               child: Container(
                 width: double.infinity,

                 child: CrystalNavigationBar(
                   height: 25,
                   currentIndex: SelectedTab.values.indexOf(cubit.selectedTab),
                   unselectedItemColor: Colors.white70,
                   onTap:(index) => cubit.changeBottomNavBar(index),
                   backgroundColor:  MainColors.MainColor_two ,
                   items: [
                     CrystalNavigationBarItem(
                       icon: Icons.home,
                       selectedColor: Colors.white,
                       unselectedColor: MainColors.grey_dot,
                     ),
                     CrystalNavigationBarItem(
                       icon: Icons.stars,
                       selectedColor: Colors.white,
                       unselectedColor: MainColors.grey_dot,
                     ),
                     CrystalNavigationBarItem(
                       icon: Icons.person,
                       selectedColor: Colors.white,
                       unselectedColor: MainColors.grey_dot,
                     ),
                     CrystalNavigationBarItem(
                       icon: Icons.check,
                       selectedColor: Colors.white,
                       unselectedColor: MainColors.grey_dot,
                     ),
                   ],),
               ),
             ),
           );
      },

    );
  }
}
