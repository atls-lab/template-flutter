import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import '../../../app/router/router.dart';
import '../auth.dart';
import 'get_messages_from_nodes.dart';

Future<(UiTextTypeEnum, String)> handleError(e,
    {String? flow, Box? flowBox, required Function callback}) async {
  String messages = e.toString();

  if (e is DioException) {
    final dioError = e.error;

    if (dioError is SocketException) {
      if (dioError.osError?.errorCode == 111) {
        messages = 'No connection to the server.';
      }
      return (UiTextTypeEnum.error, messages);
    }

    if (e.response?.statusCode == 303) {
      switch (flow) {
        case 'verificationFlow':
          final String? email = e.requestOptions.data?['email'] ??
              e.requestOptions.data?['identifier'];
          return await callback(email: email);
        case 'recoveryFlow':
          final String email = e.requestOptions.data['identifier'];
          return await callback(email: email);
        default:
          return await callback();
      }
    }

    if (e.response?.statusCode == 400) {
      switch (flow) {
        case 'loginFlow':
          final response = e.response?.data;
          final bool? isAccountUnverified = response['ui']?['messages']
              .any((message) => message['id'] == 4000010);
          if (isAccountUnverified != null && isAccountUnverified) {
            messages = response['ui']['messages']
                .firstWhere((message) => message['id'] == 4000010)['text'];
            final String email = e.requestOptions.data['identifier'] ??
                e.requestOptions.data['email'];
            GetIt.I<AppRouter>().replace(VerificationScreenRoute(email: email));
          }
          return callback();
        default:
          messages = getKratosMessagesFromNodes(e);
      }

      return (UiTextTypeEnum.error, messages);
    }

    if (e.response?.statusCode == 410) {
      flowBox?.delete(flow);

      switch (flow) {
        case 'verificationFlow':
          final String email = e.requestOptions.data['email'];
          return callback(email: email);
        case 'recoveryFlow':
          final String email = e.requestOptions.data['identifier'];
          return callback(email: email);
        default:
          return callback();
      }
    }

    if (e.response?.statusCode == 401) {
      callback();
    }

    messages =
        '${getKratosMessagesFromNodes(e)}\n${getKratosMessages(e.response?.data)}';
  }
  return (UiTextTypeEnum.error, messages);
}
