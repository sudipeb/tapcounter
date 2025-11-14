import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tapcounter/features/userprofile/data/models/user_model.dart';

///[UserCubit] creation using the [User] class
///
///performs [createUser],[loadCurrentUser],[updateUser] tasks

class UserCubit extends Cubit<User?> {
  UserCubit() : super(null);
  final Box<User> _userBox = Hive.box<User>('user_profile');

  void createUser(User user) {
    _userBox.add(user);
    emit(user);
    debugPrint(
      'User created: ${user.name}, ${user.email}, ${user.age}, ${user.imageUrl}',
    );
  }

  void loadCurrentUser() {
    if (_userBox.isNotEmpty) {
      emit(_userBox.getAt(_userBox.length - 1)); // get last saved user
    }
  }

  void updateUser({String? name, String? email, String? imageUrl, int? age}) {
    if (state == null) return;

    final updated = User(
      id: state!.id,
      name: name ?? state!.name,
      email: email ?? state!.email,
      imageUrl: imageUrl ?? state!.imageUrl,
      age: age ?? state!.age,
    );

    _userBox.put(state!.id, updated);
    // HiveObject key
    emit(updated);
  }
}
