import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_tennis_ai_model/features/auth/data/model/user_model.dart';
import 'package:weather_tennis_ai_model/features/auth/domain/use_case/register_usecase.dart';

import '../../../domain/entities/login.dart';
import '../states/login_state.dart';

class SignInCubit extends Cubit<SignInStates> {
  final SignInUseCase _signInUseCase;

  SignInCubit(this._signInUseCase) : super(SignInInitialState());
  UserModel? userModel;

  // Retrieve the current cubit instance via the context.
  static SignInCubit of(BuildContext context) => BlocProvider.of<SignInCubit>(context);

  // Function to handle user sign-in logic.
  Future<void> userSignIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(SignInLoadingState());

    final userSignInEntity = SignInEntity(password: password, email: email);

    try {
      final result = await _signInUseCase(userSignInEntity);

      if (result.uId != null) {
        userModel = result;

        emit(SignInSuccessState());
      } else {
        // Handle the case where the result does not contain a valid user ID.
        emit(SignInErrorState("Invalid credentials. Please try again."));
      }
    } catch (e) {
      // Emit error state in case of an exception, providing a user-friendly error message.
      emit(SignInErrorState("An error occurred during sign-in: ${e.toString()}"));
    }
  }

  // Icon and visibility state for password field.
  IconData suffix = Icons.visibility_outlined;
  bool isPasswordVisible = true;

  // Function to toggle the visibility of the password field.
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    suffix = isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    // Emit state change to update UI when password visibility is toggled.
    emit(SeePassState());
  }
  Future<UserModel?> getUserData() async {
    try {
      emit(GetUserLoadingState());

      // Fetch user data from Firestore
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel?.uId)
          .get();

      if (documentSnapshot.exists) {
        userModel = UserModel.fromJson(documentSnapshot.data()!);
        emit(GetUserSuccessState());
        return userModel;
      } else {
        emit(GetUserErrorState("User does not exist"));
        return null;
      }
    } catch (error) {
      emit(GetUserErrorState(error.toString()));
      return null;
    }
  }
}
