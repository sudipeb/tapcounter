import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tapcounter/features/counter/presentation/tap_view.dart';

///Timer Cubit to manage the time in [TapViewPage]
class TimerCubit extends Cubit<int> {
  Timer? _timer;
  final int initialTime;
  bool isRunning = false;
  VoidCallback? onTimerEnd;
  TimerCubit({required this.initialTime}) : super(30);
  void startTimer() {
    _timer?.cancel();
    emit(initialTime);
    isRunning = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 1) {
        emit(state - 1); // normal countdown
      } else {
        // final tick: emit 0 exactly once
        emit(0);
        debugPrint('Timer ended at 0');
        isRunning = false;
        timer.cancel();
        onTimerEnd?.call();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  int get elapsedTime => initialTime - state;
  int get originalTime => initialTime;
  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
