import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/signup.dart';
import '../../../domain/use_case/login_usecase.dart';
import '../states/register_state.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  final SignUpUseCase _SignUpUseCase;

  SignUpCubit(this._SignUpUseCase) : super(SignUpInitialState());

  static SignUpCubit of(BuildContext context) =>
      BlocProvider.of<SignUpCubit>(context);

  Future<void> userSignUp({
    required String email,
    required String password,
    required String fullname,
    required BuildContext context,
  }) async {
    emit(SignUpLoadingState());
    final userSignUpEntity = SignUpEntity(password: password, email: email, fullName: fullname);
    try {
      final result = await _SignUpUseCase(userSignUpEntity);
      if(result.uId!=null){
        emit(SignUpSuccessState());
      }
    }catch(e){
      emit(SignUpErrorState(e.toString()));
    }
  }
}