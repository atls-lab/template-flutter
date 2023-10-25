import 'package:built_value/json_object.dart';
import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class UITextAdapter extends TypeAdapter<UiText> {
  @override
  UiText read(BinaryReader reader) {
    return UiText(reader.read());
  }

  @override
  final typeId = 9;

  @override
  void write(BinaryWriter writer, UiText obj) {
    writer
      ..write<UiTextTypeEnum>(obj.type)
      ..writeInt(obj.id)
      ..writeString(obj.text)
      ..write<JsonObject?>(obj.context);
  }
}
