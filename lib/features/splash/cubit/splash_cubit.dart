import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tapcounter/core/device_info.dart';
import 'package:tapcounter/features/splash/cubit/splash_state.dart';
import 'package:tapcounter/features/userprofile/data/models/user_model.dart';

///splash cubit that uses [SplashState]
///
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> startSplash() async {
    emit(SplashLoading());
    await Future.delayed(const Duration(seconds: 2));
    final userBox = Hive.box<User>('user_profile');
    final deviceBox = Hive.box('deviceSettings');

    final deviceId = await getDeviceId();
    final firstTime = deviceBox.get(deviceId) != 'completed';

    if (firstTime) {
      // mark as done
      deviceBox.put(deviceId, 'completed');
      emit(SplashNavigateToRegistration());
    } else if (userBox.isNotEmpty) {
      emit(SplashNavigateToHome());
    } else {
      //USER NOT
      emit(SplashNavigateToRegistration());
    }
  }
}
