// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:tapcounter/features/counter/presentation/history_page.dart'
    as _i1;
import 'package:tapcounter/features/counter/presentation/tap_view.dart' as _i3;
import 'package:tapcounter/features/settings/user_settings.dart' as _i2;

/// generated route for
/// [_i1.HistoryPage]
class HistoryRoute extends _i4.PageRouteInfo<void> {
  const HistoryRoute({List<_i4.PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.HistoryPage();
    },
  );
}

/// generated route for
/// [_i2.SettingsPage]
class SettingsRoute extends _i4.PageRouteInfo<void> {
  const SettingsRoute({List<_i4.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.SettingsPage();
    },
  );
}

/// generated route for
/// [_i3.TapViewPage]
class TapViewRoute extends _i4.PageRouteInfo<void> {
  const TapViewRoute({List<_i4.PageRouteInfo>? children})
    : super(TapViewRoute.name, initialChildren: children);

  static const String name = 'TapViewRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.TapViewPage();
    },
  );
}
