import 'package:bloc/bloc.dart';
import 'package:tapcounter/features/counter/presentation/tap_view.dart';

///for  managing the state for[isCountingDown] in [TapViewPage]
class CountdownCubit extends Cubit<int?> {
  CountdownCubit() : super(null); // null means no countdown active

  Future<void> startCountdown(int seconds) async {
    emit(seconds);
    for (var i = seconds; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      emit(i - 1);
    }
    emit(null); // Countdown finished
  }

  bool get isCountingDown => state != null && state! > 0;
}
