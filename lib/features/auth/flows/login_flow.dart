import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_of/one_of.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import '../auth.dart';

class AppLoginFlow {
  Box<String>? _flowBox;
  LoginFlow? _flow;
  String? _flowId;
  final String _flowName = 'loginFlow';
  late Box _sessionBox;
  CancelToken cancelToken = CancelToken();

  AppLoginFlow() {
    _flowBox = Hive.box('flow');
    _sessionBox = Hive.box('session');
  }

  Future<void> expiredFlowFallBack() async {
    await checkIfFlowExpired(
        flow: _flow,
        fallback: initHandlersLoginScreen,
        flowBox: _flowBox,
        flowName: _flowName);
  }

  Future<void> clearAll() async {
    _flowBox?.delete(_flowName);
    _flowId = null;
    _flow = null;
  }

  Future<(UiTextTypeEnum, String)> initHandlersLoginScreen() async {
    Response<LoginFlow> response;
    String message;
    UiTextTypeEnum type;
    BuiltList<UiText>? messages = BuiltList();

    try {
      _flowId = _flowBox?.get(_flowName);

      if (_flowId == null) {
        response =
            await kratos.createNativeLoginFlow(cancelToken: cancelToken);
      } else {
        response = await kratos.getLoginFlow(id: _flowId!, cancelToken: cancelToken);
        await expiredFlowFallBack();
      }

      _flow = response.data;

      if (_flow != null) {
        _flowBox?.put(_flowName, _flow!.id);
        _flowId = _flow!.id;

        messages = _flow!.ui.messages;
      }

      type = checkMessageTypes(messages);
      message = getKratosMessages(response);

      return (type, message);
    } catch (error) {
      return handleError(error,
          callback: initHandlersLoginScreen,
          flow: _flowName,
          flowBox: _flowBox);
    }
  }

  Future<(UiTextTypeEnum, String)> loginHandler({
    required String email,
    required String password,
  }) async {
    String message;
    UiTextTypeEnum type = UiTextTypeEnum.error;

    try {
      if (_flowId == null || _flow == null) {
        await initHandlersLoginScreen();

        if (_flowId == null) {
          throw ('Cannot obtain login flow. Are you already logged in?');
        }
      }

      await expiredFlowFallBack();

      final body = UpdateLoginFlowBody((b) => b
        ..oneOf = OneOf1(
            value: UpdateLoginFlowWithPasswordMethod((b) => b
              ..password = password
              ..method = 'password'
              ..identifier = email)));

      final response = await kratos.updateLoginFlow(
          flow: _flowId!, updateLoginFlowBody: body, cancelToken:
      cancelToken, );

      SuccessfulNativeLogin? nativeLoginFlow = response.data;

      if (nativeLoginFlow != null) {
        _flowBox?.delete(_flowName);
        _sessionBox.put('sessionToken', nativeLoginFlow.sessionToken);

        authenticationService.isAuthenticated();
        type = UiTextTypeEnum.success;
        clearAll();
      }

      message = getKratosMessages(response);

      return (type, message);
    } catch (error) {
      return handleError(error,
          flowBox: _flowBox,
          flow: _flowName,
          callback: initHandlersLoginScreen);
    }
  }
}
