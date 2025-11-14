import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tapcounter/features/userprofile/data/models/user_model.dart';
import 'package:tapcounter/features/userprofile/data/presentation/cubit/user_cubit.dart';

@RoutePage()
/// Shows the [User] data input from [UserInputPage] in a decorated layout
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(context) {
    // Load the current user when this page builds
    context.read<UserCubit>().loadCurrentUser();

    return BlocBuilder<UserCubit, User?>(
      builder: (context, user) {
        if (user == null) {
          return const Scaffold(
            body: Center(
              child: Text('No user found', style: TextStyle(fontSize: 18)),
            ),
          );
        }

        final file = File(user.imageUrl);

        return Scaffold(
          appBar: AppBar(
            title: const Text('User Profile Settings'),
            backgroundColor: Colors.orange.shade100,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Avatar
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.orange.shade200,
                  backgroundImage: file.existsSync() ? FileImage(file) : null,
                  child: !file.existsSync()
                      ? const Icon(Icons.person, size: 70, color: Colors.white)
                      : null,
                ),
                const SizedBox(height: 24),

                // Name Card
                _buildInfoCard(
                  icon: Icons.person,
                  label: 'Name',
                  value: user.name,
                ),

                // Email Card
                _buildInfoCard(
                  icon: Icons.email,
                  label: 'Email',
                  value: user.email,
                ),

                // Age Card
                _buildInfoCard(
                  icon: Icons.cake,
                  label: 'Age',
                  value: user.age.toString(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Helper method to create a decorated info card
  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      shadowColor: Colors.orange.shade200,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.orange.shade300,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ),
    );
  }
}
