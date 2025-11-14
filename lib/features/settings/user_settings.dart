import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tapcounter/features/userprofile/data/models/user_model.dart';
import 'package:tapcounter/features/userprofile/data/presentation/cubit/user_cubit.dart';
import 'package:tapcounter/features/userprofile/data/presentation/screens/user_input.dart';

@RoutePage()
///for showing the [User] data ibput from [UserInputPage]
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(context) {
    context.read<UserCubit>().loadCurrentUser();

    return BlocBuilder<UserCubit, User?>(
      builder: (context, user) {
        if (user == null) {
          return const Center(child: Text('No user found'));
        }
        final file = File(user.imageUrl);
        if (!file.existsSync()) {
          debugPrint('File not found at path: ${user.imageUrl}');
        }

        return Scaffold(
          appBar: AppBar(title: Text('User Profile Settings')),
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: File(user.imageUrl).existsSync()
                      ? FileImage(File(user.imageUrl))
                      : null,
                  child: !File(user.imageUrl).existsSync()
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Name'),
                    subtitle: Text(user.name),
                    leading: const Icon(Icons.person),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Email'),
                    subtitle: Text(user.email),
                    leading: const Icon(Icons.email),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Age'),
                    subtitle: Text(user.age.toString()),
                    leading: const Icon(Icons.cake),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
