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
        _imageController.text = path;
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  // Helper to build text fields
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 212, 221),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Creative gradient header
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 222, 233, 238),
                        Color.fromARGB(255, 26, 163, 227),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 24,
                  child: Text(
                    "Welcome!\nPlease Sign Up to continue",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black26,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Image.asset("assets/signup.png"),

            // Form fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  _buildTextField(_nameController, 'Full Name', Icons.person),
                  const SizedBox(height: 16),
                  _buildTextField(_emailController, 'Email', Icons.email),
                  const SizedBox(height: 16),
                  _buildTextField(
                    _ageController,
                    'Age',
                    Icons.cake,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: () async {
                      await _pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.photo, color: Colors.deepOrange),
                    label: const Text(
                      'Pick Image',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color.fromARGB(255, 109, 47, 224),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final user = User(
                          id: const Uuid().v4(),
                          name: _nameController.text,
                          email: _emailController.text,
                          imageUrl: _imageController.text,
                          age: int.tryParse(_ageController.text) ?? 0,
                        );
                        context.read<UserCubit>().createUser(user);
                        context.router.push(TapViewRoute());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User data submitted!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Submit', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
