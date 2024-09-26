import '../../data/model/user_model.dart';

abstract class AuthRepository {
  Stream<UserModel?> get user;
  Future<UserModel> signUpWithEmailAndPassword(String email, String password,String fullName);
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}