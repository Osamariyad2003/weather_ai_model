
import '../../data/model/user_model.dart';
import '../entities/login.dart';
import '../repositories/auth.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<UserModel> call(SignInEntity signInEntity) async {

    if (!signInEntity.isValidPassword()) {
      throw Exception('Password must be at least 6 characters.');
    }

    return await repository.signInWithEmailAndPassword(
      signInEntity.email,
      signInEntity.password,
    );
  }
}
