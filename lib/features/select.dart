import 'package:flutter/material.dart';
import 'package:weather_tennis_ai_model/core/components/routing.dart';
import 'package:weather_tennis_ai_model/features/auth/presention/screens/login.dart';
import 'package:weather_tennis_ai_model/features/auth/presention/screens/register.dart';

import '../core/utilies/main_colors.dart';

class SelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, // You can change the gradient direction
              end: Alignment.bottomCenter,
              colors: [
                MainColors.MainColor_two,
                MainColors.MainColor_one
              ],
            ),
          ), // Dark blue background
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: screenHeight * 0.6,
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sign Up button
                SizedBox(
                  width: screenWidth * 0.7,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      navigateTo(context, SignUpScreen());
                      //
                    },
                    style: ElevatedButton.styleFrom(

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: MainColors.blue


                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Log In button
                SizedBox(
                  width: screenWidth * 0.7,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      navigateTo(context, SignInScreen());
                    //  navigateTo(context, widget);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: BorderSide(color: Colors.white),
                    ),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}