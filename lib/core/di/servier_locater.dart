import 'package:get_it/get_it.dart';
import 'package:weather_tennis_ai_model/features/auth/domain/use_case/login_usecase.dart';
import 'package:weather_tennis_ai_model/features/auth/domain/use_case/register_usecase.dart';
import 'package:weather_tennis_ai_model/features/auth/presention/controller/cubit/login_cubit.dart';
import 'package:weather_tennis_ai_model/features/auth/presention/controller/cubit/register_cubit.dart';

import '../../features/auth/data/data_sorcue/auth_data_source.dart';
import '../../features/auth/data/repository/auth_imp.dart';
import '../../features/auth/domain/repositories/auth.dart';
import '../helper/cache_helper.dart';
import '../network/dio_helper.dart';

final sl = GetIt.instance;
void setupLocator() {
  // Register DioHelper
  sl.registerLazySingleton<DioHelper>(() => DioHelper());

  // Register CacheHelper
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());

  // Register RemoteDataSource
  sl.registerLazySingleton<AuthRemoteDataSourceFirebase>(
        () => AuthRemoteDataSourceFirebase(),
  );

  // Register Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    authRemoteDataSource: sl(),
  ));

  // Register UseCase
  sl.registerLazySingleton<SignInUseCase>(
        () => SignInUseCase(sl()), // Make sure this line is present and correct
  );

  sl.registerLazySingleton<SignUpUseCase>(
        () => SignUpUseCase(sl()), // Make sure this line is present and correct
  );

  // Register Cubit
  sl.registerFactory(() => SignInCubit(sl()));


  sl.registerFactory(() => SignUpCubit(sl()));
}
