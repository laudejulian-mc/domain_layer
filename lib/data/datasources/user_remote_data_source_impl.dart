import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final fb_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> getCurrentUser() async {
    final fbUser = firebaseAuth.currentUser;
    if (fbUser == null) throw Exception('No user signed in');
    final doc = await firestore.collection('users').doc(fbUser.uid).get();
    return UserModel.fromJson(doc.data()!);
  }

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final fbUser = result.user!;
    final doc = await firestore.collection('users').doc(fbUser.uid).get();
    return UserModel.fromJson(doc.data()!);
  }

  @override
  Future<UserModel> registerUser(UserModel user, String password) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: password);
    final fbUser = result.user!;
    final userMap = user.toJson()..['id'] = fbUser.uid;
    await firestore.collection('users').doc(fbUser.uid).set(userMap);
    return UserModel.fromJson(userMap);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel> updateProfile(UserModel user) async {
    await firestore.collection('users').doc(user.id).update(user.toJson());
    final doc = await firestore.collection('users').doc(user.id).get();
    return UserModel.fromJson(doc.data()!);
  }
}