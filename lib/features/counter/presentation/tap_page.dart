import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tapcounter/features/counter/cubit/tap_cubit.dart';
import 'package:tapcounter/features/counter/presentation/tap_view.dart';

class TapPage extends StatelessWidget {
  const TapPage({super.key});
  @override
  Widget build(context) {
    return BlocProvider(create: (_) => TapCubit(), child: const TapView());
  }
}
