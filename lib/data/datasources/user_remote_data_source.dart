import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getCurrentUser();
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> registerUser(UserModel user, String password);
  Future<void> signOut();
  Future<UserModel> updateProfile(UserModel user);
}