import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_tennis_ai_model/core/components/routing.dart';
import 'package:weather_tennis_ai_model/core/utilies/main_colors.dart';
import 'package:weather_tennis_ai_model/features/select.dart';

import '../core/utilies/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool _isLoggedIn;


  @override
  void initState() {
    super.initState();
   // _checkToken();
    _navigateToNextScreen();
  }

  // Future<void> _checkToken() async {
  //   CacheHelper cacheHelper = CacheHelper();
  //   String? token = await  cacheHelper.readToken();
  //   setState(() {
  //     _isLoggedIn = token != null && token.isNotEmpty;
  //   });
  //   _navigateToNextScreen();
  // }

  void _navigateToNextScreen() {
    Timer( Duration(seconds: 3), () {
     navigateAndFinish(context,SelectScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // You can change the gradient direction
            end: Alignment.bottomCenter,
            colors: [
              MainColors.MainColor_two,
              MainColors.MainColor_one
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        AppAssets.cloud,
                        fit: BoxFit.contain,
                        height: screenHeight * 0.10,
                        width: screenWidth * 0.20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        AppAssets.tennis,
                        fit: BoxFit.cover,
                        height: screenHeight * 0.10,
                        width: screenWidth * 0.20,

                      ),
                    ),
                  ],
                )
              ),
               SizedBox(height: 20),
               CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}