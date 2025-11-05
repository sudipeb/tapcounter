import 'dart:async';

import 'package:bloc/bloc.dart';

class TimerCubit extends Cubit<int> {
  Timer? _timer;
  TimerCubit() : super(30);
  void startTimer() {
    _timer?.cancel(); // cancel previous timer if any
    emit(30);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        emit(state - 1);
      } else {
        timer.cancel;
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
