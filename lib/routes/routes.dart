import 'package:auto_route/auto_route.dart';
import 'package:washpro/routes/routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: AuthWrapperRoute.page,
            children: [AutoRoute(page: HomeRoute.page)]),
        AutoRoute(initial: true, page: UnAuthWrapperRoute.page, children: [
          AutoRoute(page: LoginRoute.page),
          AutoRoute(page: ForgotPasswordRoute.page),
        ]),
      ];
}
