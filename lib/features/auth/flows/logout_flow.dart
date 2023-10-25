import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import '../kratos_client.dart';
import '../utils/utils_exporter.dart';

class AppLogoutFlow {
  late Box _sessionBox;
  CancelToken cancelToken = CancelToken();
  final String _flowName = 'logoutFlow';

  AppLogoutFlow() {
    _sessionBox = Hive.box('session');
  }

  Future<(UiTextTypeEnum, String)> logoutHandler() async {
    String message;
    UiTextTypeEnum type = UiTextTypeEnum.error;

    String sessionToken = _sessionBox.get('sessionToken');

    try {
      final body =
          PerformNativeLogoutBody((b) => b..sessionToken = sessionToken);

      final response = await kratos.performNativeLogout(
          cancelToken: cancelToken, performNativeLogoutBody: body);

      if (response.statusCode == 204) {
        _sessionBox.delete('sessionToken');
        type = UiTextTypeEnum.success;
      }

      if (type != UiTextTypeEnum.success) {
        message = getKratosMessages(response);
      } else {
        message = '';
      }

      return (type, message);
    } catch (error) {
      return handleError(error, flow: _flowName, callback: () {});
    }
  }
}
