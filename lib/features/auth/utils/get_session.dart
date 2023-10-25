import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import '../kratos_client.dart';

Future<Identity?> getIdentity(String token) async {
  Response<Session> response = await kratos.toSession(
      xSessionToken: Hive.box('session').get('sessionToken'));

  return response.data?.identity;
}
