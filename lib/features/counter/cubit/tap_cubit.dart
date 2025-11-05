import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

///A [Cubit] which manages [int] as its state
class TapCubit extends Cubit<int> {
  TapCubit() : super(0);
  //for each new taps on the screen increments the value
  void onTap() {
    emit(state + 1);
    debugPrint('Tapped! Current value: ${state + 1}');
  }
}
