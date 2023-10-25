import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import 'auth.dart';

class AuthenticationService {
  Session? _identity;
  CancelToken cancelToken = CancelToken();

  AuthenticationService();

  Future<bool> isAuthenticated() async {
    try {
      final String? token = Hive.box('session').get('sessionToken');

      final Response<Session> response = await kratos.toSession(
          xSessionToken: token, cancelToken: cancelToken);

      if (response.statusCode == 200) {
        _identity = response.data;
        return true;
      }

      getKratosMessages(response);
      return false;
    } catch (err) {
      handleError(err,
          callback: () {});
      return false;
    }
  }

  void logout() async {
    Hive.box('session').delete('sessionToken');
    _identity = null;
  }

  get identity => _identity;
}

AuthenticationService authenticationService = AuthenticationService();
