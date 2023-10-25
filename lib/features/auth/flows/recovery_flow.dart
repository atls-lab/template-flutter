import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_of/one_of.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import '../kratos_client.dart';
import '../utils/check_if_flow_expired.dart';
import '../utils/check_message_types.dart';
import '../utils/utils_exporter.dart';

class AppRecoveryFlow {
  Box<String>? _flowBox;
  String? _flowId;
  RecoveryFlow? _flow;
  final String _flowName = 'recoveryFlow';
  CancelToken cancelToken = CancelToken();
  late String _email;

  AppRecoveryFlow() {
    _flowBox = Hive.box('flow');
  }

  Future<void> expiredFlowFallBack() async {
    await checkIfFlowExpired(
        flow: _flow,
        fallback: initHandlersRecovery,
        flowBox: _flowBox,
        flowName: _flowName);
  }

  Future<void> clearAll({String? email}) async {
    _flowBox?.delete(_flowName);
    _flowId = null;
    _flow = null;
  }

  Future<(UiTextTypeEnum, String)> initHandlersRecovery(
      {required String email}) async {
    Response<RecoveryFlow> responseRequestCode;
    String message;
    BuiltList<UiText>? messages;
    UiTextTypeEnum type;

    _email = email;

    try {
      _flowId = _flowBox?.get(_flowName);

      if (_flowId == null) {
        responseRequestCode =
            await kratos.createNativeRecoveryFlow(cancelToken: cancelToken);
      } else {
        responseRequestCode = await kratos.getRecoveryFlow(id: _flowId!);

        await expiredFlowFallBack();
      }

      _flow = responseRequestCode.data;

      if (_flow != null) {
        _flowBox?.put(_flowName, _flow!.id);
        _flowId = _flow?.id;

        if (_flowId == null || _flow == null) {
          await initHandlersRecovery(email: email);
        }

        final body = UpdateRecoveryFlowBody((b) => b
          ..oneOf = OneOf1(
              value: UpdateRecoveryFlowWithCodeMethod((b) => b
                ..email = _email
                ..method = UpdateRecoveryFlowWithCodeMethodMethodEnum.code)));

        responseRequestCode = await kratos.updateRecoveryFlow(
            flow: _flowId!,
            updateRecoveryFlowBody: body,
            cancelToken: cancelToken);

        _flow = responseRequestCode.data;

        _flowId = _flow?.id;

        if (_flowId != null) {
          _flowBox?.put(_flowName, _flowId!);
        }

        messages = _flow?.ui.messages;
      }

      type = checkMessageTypes(messages);
      message = getKratosMessages(responseRequestCode);

      return (type, message);
    } catch (error) {
      return handleError(error,
          flowBox: _flowBox, flow: _flowName, callback: initHandlersRecovery);
    }
  }

  Future<(UiTextTypeEnum, String)> resendCode({required String email}) async {
    Response<RecoveryFlow> response;
    BuiltList<UiText>? messages;
    UiTextTypeEnum type;
    String message;

    try {
      if (_flow == null || _flowId == null) {
        await initHandlersRecovery(email: email);
      }

      await expiredFlowFallBack();

      final body = UpdateRecoveryFlowBody((b) => b
        ..oneOf = OneOf1(
            value: UpdateRecoveryFlowWithCodeMethod((b) => b
              ..email = _email
              ..method = UpdateRecoveryFlowWithCodeMethodMethodEnum.code)));

      response = await kratos.updateRecoveryFlow(
          flow: _flowId!,
          updateRecoveryFlowBody: body,
          cancelToken: cancelToken);

      _flow = response.data;

      if (_flow != null) {
        _flowId = _flow?.id;
        _flowBox?.put(_flowName, _flowId!);
        messages = _flow?.ui.messages;
      }

      type = checkMessageTypes(messages);
      message = getKratosMessages(response);

      return (type, message);
    } catch (error) {
      return handleError(error,
          flowBox: _flowBox, flow: _flowName, callback: initHandlersRecovery);
    }
  }

  Future<(UiTextTypeEnum, String)> recoveryHandler(
      {required String code}) async {
    String message;
    UiTextTypeEnum type;
    BuiltList<UiText>? messages;
    Response<RecoveryFlow> response;

    try {
      if (_flowId == null || _flow == null) {
        await initHandlersRecovery(email: _email);

        if (_flowId == null) {
          throw ('Cannot get new flow');
        }
      }

      await expiredFlowFallBack();

      final body = UpdateRecoveryFlowBody((b) => b
        ..oneOf = OneOf1(
            value: UpdateRecoveryFlowWithCodeMethod((b) => b
              ..method = UpdateRecoveryFlowWithCodeMethodMethodEnum.code
              ..code = code)));

      response = await kratos.updateRecoveryFlow(
          flow: _flowId!,
          updateRecoveryFlowBody: body,
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
          flowBox: _flowBox, flow: _flowName, callback: initHandlersRecovery);
    }
  }
}
