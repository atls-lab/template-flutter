import 'package:built_value/json_object.dart';
import 'package:dio/dio.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

String getKratosMessages(Response response) {
  if (response is Response<VerificationFlow> ||
      response is Response<RegistrationFlow> ||
      response is Response<LoginFlow> ||
      response is Response<RecoveryFlow> ||
      response is Response<SettingsFlow>) {
    String result = response.data?.ui.messages?.asList().map((message) {
          String mainMessage = message.text;
          JsonObject? context = message.context;

          String contextMessage = context?.asMap.values.map((e) => e
              .toString()).join(' ') ?? '';

          return '$mainMessage $contextMessage';
        }).join('\n') ??
        '';
    return result;
  }

  return response.statusMessage ?? '';
}
