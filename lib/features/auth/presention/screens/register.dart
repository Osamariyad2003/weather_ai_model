import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_tennis_ai_model/features/auth/presention/widgets/dialog.dart';
import 'package:weather_tennis_ai_model/features/home.dart';

import '../../../../core/components/error_dialog.dart';
import '../../../../core/components/routing.dart';
import '../../../../core/components/toast.dart';
import '../../../../core/utilies/main_colors.dart';
import '../../../../core/utilies/strings.dart';
import '../controller/cubit/register_cubit.dart';
import '../controller/states/register_state.dart';
import '../widgets/form_firld.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<SignUpCubit, SignUpStates>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          showToast(text: 'Login Successful', state: ToastStates.success);
          navigateTo(context, HomeScreen(nameController.text)); // Navigate on success
        } else if (state is SignUpErrorState) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ShowDialogError(
                title: "Login Failed",
                subTitle: state.error,
                functionPressed: () {
                  showToast(text: "Please try again", state: ToastStates.error);
                },
              );
            },
          );
        }
      },
      builder: (context, state) {
        var cubit = SignUpCubit.of(context);

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MainColors.MainColor_two,
                  MainColors.MainColor_one,
                ],
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Text('Sign Up',style: TextStyle(fontSize: 36,fontWeight: FontWeight.w700,color: Colors.white),),
                  SizedBox(height: 8,),
                  MyFormField(
                    title: "Full Name",
                    hint: "Enter your Full Name",
                    fill: MainColors.field_color,
                    hintStyle: TextStyle(color: Colors.white),
                    type: TextInputType.emailAddress,
                    controller: nameController,
                    maxLines: 1,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  MyFormField(
                    title: "Email",
                    hint: "Enter your email",
                    fill: MainColors.field_color,
                    hintStyle: TextStyle(color: Colors.white),
                    type: TextInputType.emailAddress,
                    controller: emailController,
                    maxLines: 1,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  MyFormField(
                    title: "Password",
                    hint: "Enter your password",
                    fill: MainColors.field_color,
                    hintStyle: TextStyle(color: Colors.white,),
                    type: TextInputType.visiblePassword,
                    controller: passwordController,
                    maxLines: 1,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  if (state is SignUpLoadingState)
                    CircularProgressIndicator()
                  else
                    SizedBox(
                      width: screenWidth * 0.95,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          showAlertDialog(context, (){ cubit.userSignUp(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context, fullname: nameController.text,
                          );

                          });


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
        // Set text color
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}