import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tapcounter/features/counter/cubit/tap_cubit.dart';

class TapView extends StatelessWidget {
  const TapView({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Faster Finger')),
      body: GestureDetector(
        onTap: () => context.read<TapCubit>().onTap,
        child: SizedBox.expand(
          child: Column(
            children: [
              BlocBuilder<TapCubit, int>(
                builder: (context, state) => Text(
                  '$state',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Text(
                'Keep tapping as You can',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
