import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_of/one_of.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import '../auth.dart';

class AppRegistrationFlow {
  Box<String>? _flowBox;
  final String _flowName = 'registrationFlow';
  RegistrationFlow? _flow;
  Box? _sessionBox;
  String? _flowId;
  CancelToken cancelToken = CancelToken();

  AppRegistrationFlow() {
    _flowBox = Hive.box('flow');
    _sessionBox = Hive.box('session');
  }

  Future<void> expiredFlowFallBack() async {
    await checkIfFlowExpired(
        flow: _flow,
        fallback: initHandlersRegistrationScreen,
        flowBox: _flowBox,
        flowName: _flowName);
  }

  Future<void> clearAll() async {
    _flowBox?.delete(_flowName);
    _flowId = null;
    _flow = null;
  }

  Future<(UiTextTypeEnum, String)> initHandlersRegistrationScreen() async {
    Response<RegistrationFlow> response;
    String message;
    UiTextTypeEnum type;
    BuiltList<UiText>? messages;

    try {
      _flowId = _flowBox?.get(_flowName);

      if (_flowId == null) {
        response =
            await kratos.createNativeRegistrationFlow(cancelToken: cancelToken);
      } else {
        response = await kratos.getRegistrationFlow(
            id: _flowId!, cancelToken: cancelToken);

        _flow = response.data;
        await expiredFlowFallBack();
      }

      _flow = response.data;
      _flowId = _flow!.id;

      if (_flow != null) {
        _flowBox?.put(_flowName, _flow!.id);
        messages = _flow?.ui.messages;
      }

      type = checkMessageTypes(messages);
      message = getKratosMessages(response);

      return (type, message);
    } catch (error) {
      return handleError(error,
          flowBox: _flowBox,
          flow: _flowName,
          callback: initHandlersRegistrationScreen);
    }
  }

  Future<(UiTextTypeEnum, String)> registrationHandler({
    required String password,
    required String email,
  }) async {
    String message;
    UiTextTypeEnum type;
    BuiltList<UiText>? messages;
    Response<SuccessfulNativeRegistration> response;

    try {
      if (_flowId == null || _flow == null) {
        await initHandlersRegistrationScreen();

        if (_flowId == null) {
          throw ('You are already signed in');
        }
      }


      await expiredFlowFallBack();

      final UpdateRegistrationFlowBody body =
          UpdateRegistrationFlowBody((b) => b
            ..oneOf = OneOf.fromValue1(
                value: UpdateRegistrationFlowWithPasswordMethod(
              (b) => b
                ..password = password
                ..method = 'password'
                ..traits = JsonObject({'email': email}),
            )));

      response =
          await kratos.updateRegistrationFlow(
              flow: _flowId!,
              updateRegistrationFlowBody: body,
              cancelToken: cancelToken);

      final SuccessfulNativeRegistration? nativeRegistrationFlow =
          response.data;

      if (nativeRegistrationFlow != null) {
        clearAll();

        // TODO: find by type or name
        ContinueWithVerificationUi? value = nativeRegistrationFlow.continueWith
            ?.asList()[0]
            .oneOf
            .value as ContinueWithVerificationUi?;

        String? verificationFlowId = value?.flow.id;

        if (verificationFlowId is String) {
          _flowBox?.put('verificationFlow', verificationFlowId);
        }

        messages = _flow?.ui.messages;
        _sessionBox?.put('sessionToken', nativeRegistrationFlow.sessionToken);
        authenticationService.isAuthenticated();
      }

      type = checkMessageTypes(messages);
      message = getKratosMessages(response);

      return (type, message);
    } catch (error) {
      return handleError(error,
          flow: _flowName,
          flowBox: _flowBox,
          callback: initHandlersRegistrationScreen);
    }
  }
}
