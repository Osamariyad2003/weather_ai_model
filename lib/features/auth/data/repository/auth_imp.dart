
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/repositories/auth.dart';
import '../data_sorcue/auth_data_source.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSourceFirebase authRemoteDataSource;

  // Inject the AuthRemoteDataSourceFirebase into the repository
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Stream<UserModel?> get user => authRemoteDataSource.user;

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      String email,
      String password,
      String fullName,
      ) async {
    try {
      // Perform the sign-up operation
      UserModel user = await authRemoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );


      // Return the updated user model
      return UserModel(
        name: fullName, // Now include the full name as the display name
        email: user.email,
        uId: user.uId,
        image: user.image,
      );
    } catch (error) {
      throw Exception('Sign up failed: $error');
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await authRemoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      throw Exception('Sign in failed: $error');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await authRemoteDataSource.signOut();
    } catch (error) {
      throw Exception('Sign out failed: $error');
    }
  }
}
