import 'package:auto_route/auto_route.dart';

import '../../features/auth/auth.dart';
import 'app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    authenticationService.isAuthenticated().then((res) {
      if (res == true) {
        resolver.next(true);
      } else {
        resolver.redirect(const LoginScreenRoute());
      }
    });
  }
}
