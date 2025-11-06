import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tapcounter/features/counter/cubit/tap_cubit.dart';
import 'package:tapcounter/features/counter/cubit/timer_cubit.dart';

import 'package:tapcounter/features/widgets/bottom_nav_bar.dart';

@RoutePage()
class TapViewPage extends StatelessWidget {
  const TapViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final decoration = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Faster Finger', style: decoration.displayMedium),
        actions: [
          IconButton(
            icon: Icon(Icons.toggle_on),
            onPressed: () => context.read<ToggleCubit>().toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tap area takes remaining space
            Expanded(
              child: BlocListener<TimerCubit, int>(
                listener: (context, timer) {
                  if (timer == 0 && context.read<TapCubit>().state > 0) {
                    final originalTime = context
                        .read<TimerCubit>()
                        .originalTime;
                    context.read<TapCubit>().saveSession(originalTime);
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    final timerCubit = context.read<TimerCubit>();
                    if (timerCubit.isRunning && timerCubit.state > 0) {
                      context.read<TapCubit>().onTap();
                    }
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<TapCubit, int>(
                          builder: (context, state) =>
                              Text('$state', style: decoration.displayLarge),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Keep tapping as you can',
                          style: decoration.displayMedium,
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<TimerCubit, int>(
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.play_arrow),
                                  onPressed: () {
                                    final timerCubit = context
                                        .read<TimerCubit>();
                                    final tapCubit = context.read<TapCubit>();

                                    tapCubit.resetTaps();
                                    timerCubit.startTimer();
                                  },
                                ),
                                Text('$state'),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom navigation bar stays fixed at bottom
            ),
            SizedBox(height: 56, child: BottomNavBar()),
          ],
        ),
      ),
    );
  }
}
