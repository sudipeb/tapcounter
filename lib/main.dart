import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tapcounter/app_route.dart';
import 'package:tapcounter/core/app_theme.dart';
import 'package:tapcounter/features/counter/cubit/nav_bar_cubit.dart';
import 'package:tapcounter/features/counter/cubit/tap_cubit.dart';
import 'package:tapcounter/features/counter/cubit/timer_cubit.dart';
import 'package:tapcounter/features/counter/data/models/tap_session_model.dart';
import 'package:tapcounter/features/userprofile/data/models/user_model.dart';
import 'package:tapcounter/features/userprofile/data/presentation/cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  //Register the manual TypeAdapter
  Hive.registerAdapter(TapSessionAdapter());
  await Hive.openBox<TapSession>('tap_sessions');
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('user_profile');
  await Hive.openBox('deviceSettings');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    final appRouter = AppRouter();
    final timerCubit = TimerCubit(initialTime: 30);
    final tapCubit = TapCubit(timerCubit: timerCubit);

    // connect the two cubits
    timerCubit.onTimerEnd = () => tapCubit.saveSession(timerCubit.originalTime);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavBarCubit()),
        BlocProvider.value(value: tapCubit), // reuse the same instance
        BlocProvider(create: (_) => ToggleCubit()),
        BlocProvider.value(value: timerCubit), // reuse the same instance
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => UserCubit()),
      ],
      child: BlocBuilder<ToggleCubit, ThemeMode>(
        builder: (context, thememode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: thememode,
            routerConfig: appRouter.config(),
          );
        },
      ),
    );
  }
}
