import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tapcounter/features/counter/cubit/tap_cubit.dart';
import 'package:tapcounter/features/counter/cubit/timer_cubit.dart';

import 'package:tapcounter/features/widgets/bottom_nav_bar.dart';

class TapView extends StatelessWidget {
  const TapView({super.key});

  @override
  Widget build(BuildContext context) {
    final decoration = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
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
              child: GestureDetector(
                onTap: () {
                  final timerState = context.read<TimerCubit>().state;
                  if (timerState > 0) {
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
                                onPressed: () =>
                                    context.read<TimerCubit>().startTimer(),
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
            const SizedBox(height: 56, child: BottomNavBar()),
          ],
        ),
      ),
    );
  }
}
