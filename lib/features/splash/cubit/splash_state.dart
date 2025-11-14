import 'package:equatable/equatable.dart';

// Base state class for the Splash screen.
///
/// Uses [Equatable] to enable value comparison, making Bloc updates efficient.
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigateToHome extends SplashState {}

class SplashNavigateToRegistration extends SplashState {}
