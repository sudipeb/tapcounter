import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tapcounter/features/counter/cubit/timer_cubit.dart';
import 'package:tapcounter/features/counter/data/models/tap_session_model.dart';
import 'package:tapcounter/features/counter/presentation/tap_view.dart';

///A [Cubit] which manages [int] as its state and Handles tap in[TapViewPage]
class TapCubit extends Cubit<int> {
  TapCubit({required this.timerCubit}) : super(0);
  final TimerCubit timerCubit;
  bool _sessionSaved = false;

  //for each new taps on the screen increments the value
  void onTap() {
    emit(state + 1);
    debugPrint('Tapped! Current value: $state');
  }

  void resetTaps() {
    _sessionSaved = false;
    emit(0);
  }

  Future<void> saveSession(int totalTime) async {
    // final box = Hive.box<TapSession>('tap_sessions');
    if (_sessionSaved || state == 0) return; // Prevent double save
    _sessionSaved = true;
    final original = timerCubit.originalTime;
    final session = TapSession(
      totalTaps: state,
      totalTime: original,
      dateTime: DateTime.now(),
    );

    Hive.box<TapSession>('tap_sessions').add(session);
    debugPrint(
      'Session saved: ${session.totalTaps} taps, ${session.totalTime}s',
    );

    emit(state); // Reset tap count after saving
  }
}

void deleteSession() {
  final box = Hive.box<TapSession>('tap_sessions');
  box.deleteAll(box.keys);
}

class ToggleCubit extends Cubit<ThemeMode> {
  ToggleCubit() : super(ThemeMode.system);

  void toggleTheme() {
    if (state == ThemeMode.system) {
      emit(ThemeMode.light);
    } else if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.system);
    }
  }
}
