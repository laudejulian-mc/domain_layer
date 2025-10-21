// ignore_for_file: override_on_non_overriding_member

import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dartz/dartz.dart';
import 'package:hoophub/core/errors/failure.dart' hide Failure;
import 'package:hoophub/domain/entities/Failure.dart';
import 'package:hoophub/domain/entities/userEntity.dart';
import 'package:hoophub/domain/repositories/repositoryInterface.dart';

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

mixin UserModel {
  static Future<UserModel> fromJson(Map<String, dynamic> map) async {}
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  Future<Object> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Object> signInWithEmail(String email, String password) async {
    try {
      final user = await remoteDataSource.signInWithEmail(email, password);
      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Object> registerUser(User user, String password) async {
    try {
      final userModel = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        photoUrl: user.photoUrl,
      );
      final registeredUser = await remoteDataSource.registerUser(userModel, password);
      return Right(registeredUser);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Object> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Object> updateProfile(User user) async {
    try {
      final userModel = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        photoUrl: user.photoUrl,
      );
      final updatedUser = await remoteDataSource.updateProfile(userModel);
      return Right(updatedUser);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, User>> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> register(String email, String password, UserRole role) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  
  UserModel({required String id, required String name, required String email, required UserRole role, String? photoUrl}) {}
}

class UserRemoteDataSource {
}

