// Import the new entity

import '../../data/model/user_model.dart';
import '../entities/signup.dart';
import '../repositories/auth.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);
  Future<UserModel> call(SignUpEntity signUpEntity) async {
    if (!signUpEntity.isValidPassword()) {
      throw Exception('Password must be at least 6 characters.');
    }
    return await repository.signUpWithEmailAndPassword(
      signUpEntity.email,
      signUpEntity.password,
      signUpEntity.fullName,

    );
  }
}
