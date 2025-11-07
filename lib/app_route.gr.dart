// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:tapcounter/features/counter/presentation/history_page.dart'
    as _i1;
import 'package:tapcounter/features/counter/presentation/tap_view.dart' as _i3;
import 'package:tapcounter/features/settings/user_settings.dart' as _i2;
import 'package:tapcounter/features/userprofile/data/presentation/screens/user_input.dart'
    as _i4;

/// generated route for
/// [_i1.HistoryPage]
class HistoryRoute extends _i5.PageRouteInfo<void> {
  const HistoryRoute({List<_i5.PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HistoryPage();
    },
  );
}

/// generated route for
/// [_i2.SettingsPage]
class SettingsRoute extends _i5.PageRouteInfo<void> {
  const SettingsRoute({List<_i5.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.SettingsPage();
    },
  );
}

/// generated route for
/// [_i3.TapViewPage]
class TapViewRoute extends _i5.PageRouteInfo<void> {
  const TapViewRoute({List<_i5.PageRouteInfo>? children})
    : super(TapViewRoute.name, initialChildren: children);

  static const String name = 'TapViewRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.TapViewPage();
    },
  );
}

/// generated route for
/// [_i4.UserInputPage]
class UserInputRoute extends _i5.PageRouteInfo<UserInputRouteArgs> {
  UserInputRoute({_i6.Key? key, List<_i5.PageRouteInfo>? children})
    : super(
        UserInputRoute.name,
        args: UserInputRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'UserInputRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserInputRouteArgs>(
        orElse: () => const UserInputRouteArgs(),
      );
      return _i4.UserInputPage(key: args.key);
    },
  );
}

class UserInputRouteArgs {
  const UserInputRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'UserInputRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserInputRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}
