import 'package:auto_route/auto_route.dart';

import 'app_auth_guard.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: IdentityScreenRoute.page,
          path: '/auth',
          initial: true,
          children: [
            RedirectRoute(path: '', redirectTo: 'registration'),
            CustomRoute(
              page: RegistrationScreenRoute.page,
              path: 'registration',
              initial: true,
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 0,
            ),
            CustomRoute(
              page: LoginScreenRoute.page,
              path: 'login',
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 0,
            ),
          ],
        ),
        CustomRoute(
          page: VerificationScreenRoute.page,
          path: '/auth/verification',
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
        ),
        CustomRoute(
          page: RecoveryScreenRoute.page,
          path: '/auth/recovery',
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 0,
        ),
        AutoRoute(page: IndexScreenRoute.page, path: '/', guards: [
          AuthGuard()
        ], children: [
          RedirectRoute(path: '', redirectTo: 'home'),
          CustomRoute(
            page: HomeScreenRoute.page,
            path: 'home',
            transitionsBuilder: TransitionsBuilders.noTransition,
            durationInMilliseconds: 0,
          ),
      ];
}

@RoutePage(name: 'MainRouter')
class MainRouterPage extends AutoRouter {
  const MainRouterPage({super.key});
}
