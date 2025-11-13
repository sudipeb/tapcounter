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
class UserInputPage extends StatefulWidget {
  const UserInputPage({super.key});

  @override
  State<UserInputPage> createState() => _UserInputPageState();
}

///using [TextEditingController] to handle the inputs
class _UserInputPageState extends State<UserInputPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  // Notifier to hold picked image
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);
  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  ///key for [Form] validation
  final _formKey = GlobalKey<FormState>();

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

  /// Helper method to create a text field with validation
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  /// Method to [_submitForm]and validate input
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_imageController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please pick an image')));
        return;
      }

      final user = User(
        id: const Uuid().v4(),
        name: _nameController.text,
        email: _emailController.text,
        imageUrl: _imageController.text,
        age: int.tryParse(_ageController.text) ?? 0,
      );

      context.read<UserCubit>().createUser(user);
      context.router.push(TapViewRoute());

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User data submitted!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 212, 221),
      body: Stack(
        children: [
          // Header
          Container(
            height: 200,
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
            top: 120,
            left: 24,
            child: Text(
              "Welcome!\nPlease Sign Up to continue",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                shadows: const [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black26,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),

          // Form and content
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 200,
              left: 24,
              right: 24,
              bottom: 32,
            ),
            child: Column(
              children: [
                Image.asset("assets/signup.png"),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        _nameController,
                        'Full Name',
                        Icons.person,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter your name'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        _emailController,
                        'Email',
                        Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your email';
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        _ageController,
                        'Age',
                        Icons.cake,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your age';
                          }
                          final age = int.tryParse(value);
                          if (age == null || age <= 0) {
                            return 'Enter a valid age';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.photo, color: Colors.deepOrange),
                        label: const Text(
                          'Pick Image',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: const Color.fromARGB(
                            255,
                            109,
                            47,
                            224,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
