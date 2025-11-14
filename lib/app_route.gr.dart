// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:tapcounter/features/counter/presentation/history_page.dart'
    as _i2;
import 'package:tapcounter/features/counter/presentation/tap_view.dart' as _i5;
import 'package:tapcounter/features/settings/user_settings.dart' as _i3;
import 'package:tapcounter/features/splash/presentation/splash.dart' as _i4;
import 'package:tapcounter/features/userprofile/data/presentation/screens/user_input.dart'
    as _i6;
import 'package:tapcounter/features/widgets/bottom_nav_bar.dart' as _i1;

/// generated route for
/// [_i1.BottomNavBarPage]
class BottomNavBarRoute extends _i7.PageRouteInfo<BottomNavBarRouteArgs> {
  BottomNavBarRoute({_i8.Key? key, List<_i7.PageRouteInfo>? children})
    : super(
        BottomNavBarRoute.name,
        args: BottomNavBarRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'BottomNavBarRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BottomNavBarRouteArgs>(
        orElse: () => const BottomNavBarRouteArgs(),
      );
      return _i1.BottomNavBarPage(key: args.key);
    },
  );
}

class BottomNavBarRouteArgs {
  const BottomNavBarRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'BottomNavBarRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BottomNavBarRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i2.HistoryPage]
class HistoryRoute extends _i7.PageRouteInfo<void> {
  const HistoryRoute({List<_i7.PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.HistoryPage();
    },
  );
}

/// generated route for
/// [_i3.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.SettingsPage();
    },
  );
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashPage();
    },
  );
}

/// generated route for
/// [_i5.TapViewPage]
class TapViewRoute extends _i7.PageRouteInfo<void> {
  const TapViewRoute({List<_i7.PageRouteInfo>? children})
    : super(TapViewRoute.name, initialChildren: children);

  static const String name = 'TapViewRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.TapViewPage();
    },
  );
}

/// generated route for
/// [_i6.UserInputPage]
class UserInputRoute extends _i7.PageRouteInfo<void> {
  const UserInputRoute({List<_i7.PageRouteInfo>? children})
    : super(UserInputRoute.name, initialChildren: children);

  static const String name = 'UserInputRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.UserInputPage();
    },
  );
}
