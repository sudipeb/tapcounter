import 'package:auto_route/auto_route.dart';
import 'package:tapcounter/app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: UserInputRoute.page),
    AutoRoute(page: TapViewRoute.page),
    AutoRoute(page: HistoryRoute.page),
    AutoRoute(page: SettingsRoute.page),
  ];
}
