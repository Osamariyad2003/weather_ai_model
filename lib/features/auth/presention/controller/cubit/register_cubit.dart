import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user_model.dart';
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
        userCreate(name: fullname, email: email, uid: result.uId);
        emit(SignUpSuccessState());
      }
    }catch(e){
      emit(SignUpErrorState(e.toString()));
    }
  }
  void userCreate({
    required String name,
    required String email,
    required String? uid,
  }) async {
    emit(SignUpCreateUserLoadingState());
    UserModel model = UserModel(name: name,email: email,uId: uid,
        image: 'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg');
    FirebaseFirestore.instance.collection('users').doc(uid).set(
      model.toJson(),
    ).then((value){

      emit(SignUpCreateUserSuccessState());

    }).catchError((error){
      print(error);
      emit(SignUpCreateUserErrorState(error.toString()));
    });

  }
}