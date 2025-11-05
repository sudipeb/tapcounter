import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tapcounter/features/counter/cubit/tap_cubit.dart';
import 'package:tapcounter/features/counter/cubit/timer_cubit.dart';

class TapView extends StatelessWidget {
  const TapView({super.key});
  @override
  Widget build(context) {
    final decoration = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Faster Finger', style: decoration.displayMedium),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.toggle_on),
            onPressed: () => context.read<ToggleCubit>().toggleTheme(),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => context.read<TapCubit>().onTap(),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<TapCubit, int>(
                builder: (context, state) =>
                    Text('$state', style: decoration.displayLarge),
              ),
              Center(
                child: Text(
                  'Keep tapping as You can',
                  style: decoration.displayMedium,
                ),
              ),
              BlocBuilder<TimerCubit, int>(
                bloc: context.read<TimerCubit>(),
                builder: (context, state) {
                  return Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.play_arrow),
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
    );
  }
}
