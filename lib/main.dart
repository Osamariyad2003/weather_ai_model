import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_tennis_ai_model/core/network/dio_helper.dart';
import 'package:weather_tennis_ai_model/features/auth/presention/controller/cubit/login_cubit.dart';
import 'package:weather_tennis_ai_model/features/auth/presention/controller/cubit/register_cubit.dart';
import 'package:weather_tennis_ai_model/features/splach_screen.dart';
import 'bloc_observer.dart';
import 'core/di/servier_locater.dart';
import 'features/weather/presentition/controller/bloc/weather_cubit.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  setupLocator();
    await DioHelper.internal();// Make sure to call setupLocator() to register everything

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => SignInCubit(sl()),
      ),
      BlocProvider(
        create: (context) => SignUpCubit(sl()),
      ),
      BlocProvider(
        create:(context) => WeatherCubit(sl(),sl())..getCurrentCity(),
      ),
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,

      home:  SplashScreen(),
    ));


  }
}


