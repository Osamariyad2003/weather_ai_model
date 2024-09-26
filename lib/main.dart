import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_tennis_ai_model/features/auth/domain/use_case/register_usecase.dart';
import 'package:weather_tennis_ai_model/features/auth/presention/controller/cubit/login_cubit.dart';
import 'package:weather_tennis_ai_model/features/auth/presention/controller/cubit/register_cubit.dart';
import 'package:weather_tennis_ai_model/features/splach_screen.dart';

import 'bloc_observer.dart';
import 'core/di/servier_locater.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  setupLocator(); // Make sure to call setupLocator() to register everything

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
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,

      home:  SplashScreen(),
    ));


  }
}


