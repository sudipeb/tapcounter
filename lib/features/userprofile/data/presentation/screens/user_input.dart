import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tapcounter/app_route.gr.dart';
import 'package:tapcounter/features/userprofile/data/models/user_model.dart';
import 'package:tapcounter/features/userprofile/data/presentation/cubit/user_cubit.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class UserInputPage extends StatelessWidget {
  UserInputPage({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final path = pickedFile.path;
        _imageNotifier.value = File(path);
        _imageController.text = path; // Set path in TextField
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: Text('Pick Image'),
              onPressed: () async {
                await _pickImage(ImageSource.gallery);
                debugPrint('image picker tapped');
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final user = User(
                  id: Uuid().v4().toString(),
                  name: _nameController.text,
                  email: _emailController.text,
                  imageUrl: _imageController.text,
                  age: int.parse(_ageController.text),
                );
                debugPrint(
                  'Saving user with image path: ${_imageController.text}',
                );
                debugPrint(
                  'File exists? ${File(_imageController.text).existsSync()}',
                );
                context.router.push(TapViewRoute());
                context.read<UserCubit>().createUser(user);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User data submitted!')),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
