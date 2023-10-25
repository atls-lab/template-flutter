import 'package:built_collection/built_collection.dart';
import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class UINodeAdapter extends TypeAdapter<UiNode> {
  @override
  UiNode read(BinaryReader reader) {
    return UiNode(reader.read());
  }

  @override
  final typeId = 6;

  @override
  void write(BinaryWriter writer, UiNode obj) {
    writer
      ..write<UiNodeTypeEnum>(obj.type)
      ..write<UiNodeGroupEnum>(obj.group)
      ..write<BuiltList<UiText>>(obj.messages)
      ..write<UiNodeAttributes>(obj.attributes);
  }
}
