import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tapcounter/core/app_theme.dart';
import 'package:tapcounter/features/counter/cubit/tap_cubit.dart';
import 'package:tapcounter/features/counter/presentation/tap_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TapCubit()),
        BlocProvider(create: (_) => ToggleCubit()),
      ],
      child: BlocBuilder<ToggleCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: const TapView(),
          );
        },
      ),
    );
  }
}
