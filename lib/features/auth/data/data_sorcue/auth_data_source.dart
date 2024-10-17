import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../model/user_model.dart';

class AuthRemoteDataSourceFirebase {
  AuthRemoteDataSourceFirebase({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// Stream to get the current authentication state (user logged in or not)
  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      }
      return UserModel(
        name: firebaseUser.displayName,
        email: firebaseUser.email,
        uId: firebaseUser.uid,
        image: 'https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg',
      );
    });
  }

  /// Sign up using email and password
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      firebase_auth.UserCredential credential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Sign up failed: The user is null after sign up.');
      }
      firebase_auth.User? user = credential.user;
      if (user != null) {
        await user.updateDisplayName(fullName);
        await user.reload();  // Refresh the user's information
      }

      return UserModel(
        name: credential.user!.displayName,
        email: credential.user!.email,
        uId: credential.user!.uid,
        image: credential.user!.photoURL??'https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg',
      );
    } catch (error) {
      throw Exception('Sign up failed: $error');
    }
  }

  /// Sign in using email and password
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in the user with email and password
      firebase_auth.UserCredential credential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Sign in failed: The user is null after sign in.');
      }

      // Convert the Firebase user to a UserModel instance
      return UserModel(
        name: credential.user!.displayName,
        email: credential.user!.email,
        uId: credential.user!.uid,
        image: credential.user!.photoURL,
      );
    } catch (error) {
      throw Exception('Sign in failed: $error');
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      throw Exception('Sign out failed: $error');
    }
  }
}
