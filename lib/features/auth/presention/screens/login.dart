import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_tennis_ai_model/core/utilies/strings.dart';
import 'package:weather_tennis_ai_model/features/auth/domain/repositories/auth.dart';
import 'package:weather_tennis_ai_model/features/auth/domain/use_case/register_usecase.dart';

import '../../../../core/components/error_dialog.dart';
import '../../../../core/components/routing.dart';
import '../../../../core/components/toast.dart';
import '../../../../core/utilies/main_colors.dart';
import '../../data/repository/auth_imp.dart';
import '../controller/cubit/login_cubit.dart';
import '../controller/states/login_state.dart';
import '../widgets/form_firld.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

// Define MainColors class with provided colors


class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<SignInCubit, SignInStates>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          showToast(text: 'Login Successful', state: ToastStates.success);
          // navigateTo(context, YourNextScreen()); // Navigate on success
        } else if (state is SignInErrorState) {
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
        var cubit = SignInCubit.of(context);

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
                  Text(AppStrings.login,style: TextStyle(fontSize: 36,fontWeight: FontWeight.w700,color: Colors.white),),
                  SizedBox(height: 8,),
                  Text('Create An Account To Make SDFSDF',style:TextStyle(color: Colors.white,fontSize: 15) ,),
                  

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
                  SizedBox(height: 16),
                  MyFormField(
                    title: "Password",
                    hint: "Enter your password",
                    fill: MainColors.field_color,
                    hintStyle: TextStyle(color: Colors.white,),
                    isPassword: cubit.isPasswordVisible,
                    type: TextInputType.visiblePassword,
                    controller: passwordController,
                    maxLines: 1,
                    suffixIcon: cubit.suffix,
                    suffixIconPressed: cubit.togglePasswordVisibility,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  if (state is SignInLoadingState)
                    CircularProgressIndicator()
                  else
                    SizedBox(
                      width: screenWidth * 0.95,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.userSignIn(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context,
                          );
                          //
                        },
                        style: ElevatedButton.styleFrom(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: MainColors.blue


                        ),
                        child: Text(
                          AppStrings.login.toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 8),
                  defaultTextButton(
                    function: () {
                      // Handle Forgot Password functionality
                    },
                    text: 'Forgot your password?',color:  MainColors.blue_text, // Set text color
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
