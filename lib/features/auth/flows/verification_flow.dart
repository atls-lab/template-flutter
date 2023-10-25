import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_of/one_of.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import '../auth.dart';

class AppVerificationFlow {
  Box<String>? _flowBox;
  String? _flowId;
  VerificationFlow? _flow;
  final String _flowName = 'verificationFlow';
  CancelToken cancelToken = CancelToken();

  AppVerificationFlow() {
    _flowBox = Hive.box('flow');
  }

  Future<void> expiredFlowFallBack() async {
    await checkIfFlowExpired(
        flow: _flow,
        fallback: initHandlersVerification,
        flowBox: _flowBox,
        flowName: _flowName);
  }

  Future<void> clearAll() async {
    _flowBox?.delete(_flowName);
    _flowId = null;
    _flow = null;
  }

  Future<(UiTextTypeEnum, String)> initHandlersVerification(
      {String? email}) async {
    Response<VerificationFlow> response;
    String message;
    UiTextTypeEnum type;
    BuiltList<UiText>? messages;

    try {
      _flowId = _flowBox?.get(_flowName);

      if (_flowId == null) {
        response =
            await kratos.createNativeVerificationFlow(cancelToken: cancelToken);
      } else {
        response = await kratos.getVerificationFlow(
            id: _flowId!, cancelToken: cancelToken);

        await expiredFlowFallBack();
      }
      _flow = response.data;
      _flowId = _flow?.id;

      if (_flow != null) {
        _flowBox?.put(_flowName, _flow!.id);

        messages = _flow?.ui.messages;
      }

      type = checkMessageTypes(messages);
      message = getKratosMessages(response);

      return (type, message);
    } catch (error) {
      return await handleError(error,
          flow: _flowName,
          flowBox: _flowBox,
          callback: initHandlersVerification);
    }
  }

  Future<(UiTextTypeEnum, String)> resendCode({required String email}) async {
    Response<VerificationFlow> response;
    String message;
    UiTextTypeEnum type;
    BuiltList<UiText>? messages;

    try {
      if (_flow == null || _flowId == null) {
        await initHandlersVerification();
      }

      await expiredFlowFallBack();

      final body = UpdateVerificationFlowBody((b) => b
        ..oneOf = OneOf1(
            value: UpdateVerificationFlowWithCodeMethod((b) => b
              ..email = email
              ..method = UpdateVerificationFlowWithCodeMethodMethodEnum.code)));

      response = await kratos.updateVerificationFlow(
          flow: _flowId!,
          updateVerificationFlowBody: body,
          cancelToken: cancelToken);

      _flow = response.data;

      if (_flow != null) {
        _flowId = _flow!.id;
        _flowBox?.put(_flowName, _flowId!);
        messages = _flow?.ui.messages;
      }

      type = checkMessageTypes(messages);
      message = getKratosMessages(response);

      return (type, message);
    } catch (err) {
      return await handleError(err,
          flowBox: _flowBox,
          flow: _flowName,
          callback: initHandlersVerification);
    }
  }

  Future<(UiTextTypeEnum, String)> verificationHandler(
      {required String code, String? email}) async {
    String message;
    UiTextTypeEnum type = UiTextTypeEnum.success;
    BuiltList<UiText>? messages;
    Response<VerificationFlow> response;

    try {
      if (_flowId == null || _flow == null) {
        await initHandlersVerification();

        if (_flowId == null) {
          throw ('Cannot get new flow');
        }
      }

      await expiredFlowFallBack();

      final body = UpdateVerificationFlowBody((b) => b
        ..oneOf = OneOf1(
            value: UpdateVerificationFlowWithCodeMethod((b) => b
              ..method = UpdateVerificationFlowWithCodeMethodMethodEnum.code
              ..code = code)));

      response =
          await kratos.updateVerificationFlow(
              flow: _flowId!,
              updateVerificationFlowBody: body,
              cancelToken: cancelToken);

      _flow = response.data;

      if (_flow != null) {
        messages = _flow?.ui.messages;
      }

      type = checkMessageTypes(messages);

      if (type == UiTextTypeEnum.success) {
        clearAll();
      }

      message = getKratosMessages(response);

      return (type, message);
    } catch (error) {
      return handleError(error,
          flow: _flowName,
          flowBox: _flowBox,
          callback: initHandlersVerification);
    }
  }
}
