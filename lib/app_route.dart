import 'package:auto_route/auto_route.dart';
import 'package:tapcounter/app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: TapViewRoute.page, initial: true),
  ];
}
