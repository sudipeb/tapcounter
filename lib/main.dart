import 'package:flutter/material.dart';
import 'package:tapcounter/features/counter/presentation/tap_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TapPage(),
    );
  }
}
