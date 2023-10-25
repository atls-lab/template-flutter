import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class AuthApi {
  late FrontendApi client;
  late OryKratosClient _api;

  AuthApi() {
    final Interceptor interceptor =
        InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['x-session-token'] =
          Hive.box('session').get('sessionToken');
      return handler.next(options);
    });

    _api = OryKratosClient(
        dio: Dio(BaseOptions(
            baseUrl: dotenv.env['BASE_URL'] ?? '',
            followRedirects: false)));
    final adapter = IOHttpClientAdapter();
    _api.dio.httpClientAdapter = adapter;
    _api.dio.interceptors.add(interceptor);
    client = _api.getFrontendApi();
  }
}

final AuthApi authApi = AuthApi();
final FrontendApi kratos = authApi.client;
