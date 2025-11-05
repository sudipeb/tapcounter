import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tapcounter/app_route.dart';
import 'package:tapcounter/core/app_theme.dart';
import 'package:tapcounter/features/counter/cubit/nav_bar_cubit.dart';
import 'package:tapcounter/features/counter/cubit/tap_cubit.dart';
import 'package:tapcounter/features/counter/cubit/timer_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    final _appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavBarCubit()),
        BlocProvider(create: (_) => TapCubit()),
        BlocProvider(create: (_) => ToggleCubit()),
        BlocProvider(create: (_) => TimerCubit()),
      ],
      child: BlocBuilder<ToggleCubit, ThemeMode>(
        builder: (context, thememode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: thememode,
            routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
