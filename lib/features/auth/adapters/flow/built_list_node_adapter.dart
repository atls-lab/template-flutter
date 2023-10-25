import 'package:built_collection/built_collection.dart';
import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class BuiltListNodeAdapter extends TypeAdapter<BuiltList<UiNode>> {
  @override
  BuiltList<UiNode> read(BinaryReader reader) {
    return BuiltList<UiNode>(reader.read());
  }

  @override
  final typeId = 7;

  @override
  void write(BinaryWriter writer, BuiltList<UiNode> obj) {
    writer
      ..writeInt(obj.hashCode)
      ..writeBool(obj.isNotEmpty)
      ..writeBool(obj.isEmpty)
      ..write<dynamic>(obj.first)
      ..write<dynamic>(obj.last)
      ..writeInt(obj.length)
      ..write(obj.firstOrNull)
      ..write(obj.iterator)
      ..write(obj.reversed);
  }
}
