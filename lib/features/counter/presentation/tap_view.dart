import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confetti/confetti.dart';
import 'package:tapcounter/features/counter/cubit/count_down.dart';
import 'package:tapcounter/features/counter/cubit/tap_cubit.dart';
import 'package:tapcounter/features/counter/cubit/timer_cubit.dart';

@RoutePage()
class TapViewPage extends StatefulWidget {
  const TapViewPage({super.key});

  @override
  State<TapViewPage> createState() => _TapViewPageState();
}

class _TapViewPageState extends State<TapViewPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _tapAnimationController;
  late final Animation<double> _tapAnimation;
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _tapAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 1.0,
      upperBound: 1.2,
    );
    _tapAnimation = _tapAnimationController.drive(Tween(begin: 1.0, end: 1.2));

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _tapAnimationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _handleTap() {
    final countdownCubit = context.read<CountdownCubit>();
    if (countdownCubit.isCountingDown) return; // disable taps during countdown

    final timerCubit = context.read<TimerCubit>();
    if (timerCubit.isRunning && timerCubit.state > 0) {
      final tapCubit = context.read<TapCubit>();
      tapCubit.onTap();

      _tapAnimationController.forward().then(
        (_) => _tapAnimationController.reverse(),
      );

      if (tapCubit.state % 5 == 0) {
        _confettiController.play();
      }
    }
  }

  Path _drawHeart(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, size.height / 4);

    ///Adds a cubic bezier segment that curves from the current point to the given point (x3,y3), using the control points (x1,y1) and (x2,y2).
    path.cubicTo(
      size.width * 5 / 14,
      0,
      0,
      size.height / 4,
      size.width / 2,
      size.height,
    );
    path.cubicTo(
      size.width,
      size.height / 4,
      size.width * 9 / 14,
      0,
      size.width / 2,
      size.height / 4,
    );
    path.close();
    return path;
  }

  void _restartSession() {
    context.read<CountdownCubit>().startCountdown(3).then((_) {
      if (!mounted) return;
      context.read<TapCubit>().resetTaps();
      context.read<TimerCubit>().startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final toggleButton = context.watch<ToggleCubit>().state;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Faster Finger', style: textTheme.displayMedium),
        actions: [
          IconButton(
            icon: Icon(
              toggleButton == ThemeMode.dark
                  ? Icons.toggle_off
                  : Icons.toggle_on,
            ),
            onPressed: () => context.read<ToggleCubit>().toggleTheme(),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                child: BlocListener<TimerCubit, int>(
                  listener: (context, timer) {
                    if (timer == 0 && context.read<TapCubit>().state > 0) {
                      final originalTime = context
                          .read<TimerCubit>()
                          .originalTime;
                      context.read<TapCubit>().saveSession(originalTime);
                    }
                  },
                  child: GestureDetector(
                    onTap: _handleTap,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleTransition(
                            scale: _tapAnimation,
                            child: BlocBuilder<TapCubit, int>(
                              builder: (context, taps) {
                                final timer = context.read<TimerCubit>().state;
                                debugPrint("$timer");
                                final sessionCompleted = (timer < 1);

                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  transitionBuilder: (child, animation) =>
                                      ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                  child: sessionCompleted == true
                                      ? Text(
                                          'Your Score: $taps',
                                          style: textTheme.displayLarge,
                                        )
                                      : Text(
                                          '$taps',
                                          key: ValueKey<int>(taps),
                                          style: textTheme.displayLarge,
                                        ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Keep tapping as you can',
                            style: textTheme.displayMedium,
                          ),
                          const SizedBox(height: 32),
                          BlocBuilder<TimerCubit, int>(
                            builder: (context, timer) {
                              final progress =
                                  timer /
                                  context.read<TimerCubit>().originalTime;
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircularProgressIndicator(
                                      value: progress,
                                      strokeWidth: 8,
                                    ),
                                  ),
                                  (progress == 0)
                                      ? Text(
                                          'Time UP!!!',
                                          style: textTheme.displayMedium,
                                        )
                                      : Text(
                                          '$timer',
                                          style: textTheme.displayMedium,
                                        ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: _restartSession,
                              child: const Text('Restart'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Countdown overlay
          BlocBuilder<CountdownCubit, int?>(
            builder: (context, countdown) {
              if (countdown == null || countdown <= 0) {
                return const SizedBox.shrink();
              }
              {
                return Container(
                  color: Colors.black.withValues(alpha: 0.7),
                  child: Center(
                    child: Text(
                      '$countdown',
                      style: textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
            },
          ),

          // Confetti overlay
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.red,
                Colors.pink,
                Colors.blue,
                Colors.green,
                Colors.yellow,
              ],
              numberOfParticles: 200,
              gravity: 0.5,
              createParticlePath: _drawHeart,
            ),
          ),
        ],
      ),
    );
  }
}
