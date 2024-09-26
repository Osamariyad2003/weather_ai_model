import 'package:equatable/equatable.dart';

class SignInEntity {
  final String email;
  final String password;

  SignInEntity({
    required this.email,
    required this.password,
  });


  bool isValidPassword() {
    return password.length >= 6;
  }
}