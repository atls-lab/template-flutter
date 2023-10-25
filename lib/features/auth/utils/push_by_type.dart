import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import '../../../app/router/app_router.dart';
import '../../../app/router/app_router.gr.dart';

void pushByType(UiTextTypeEnum type, PageRouteInfo destination) {
  if (type != UiTextTypeEnum.success) return;

  switch (destination) {
    case HomeScreenRoute():
      GetIt.I<AppRouter>().replaceAll([destination]);
    default:
      GetIt.I<AppRouter>().push(destination);
  }
}
