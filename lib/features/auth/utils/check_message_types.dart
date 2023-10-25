import 'package:built_collection/built_collection.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

UiTextTypeEnum checkMessageTypes(BuiltList<UiText>? messages) {
  UiTextTypeEnum type = UiTextTypeEnum.success;

  if (messages != null) {
    final bool hasSuccessMessages = messages
        .toList()
        .any((element) => element.type == UiTextTypeEnum.success);
    final bool hasInfoMessages =
        messages.toList().any((element) => element.type == UiTextTypeEnum.info);
    final bool hasErrorMessages = messages
        .toList()
        .any((element) => element.type == UiTextTypeEnum.error);
    return hasSuccessMessages
        ? UiTextTypeEnum.success
        : hasInfoMessages
            ? UiTextTypeEnum.info
            : UiTextTypeEnum.error;
  }

  return type;
}
