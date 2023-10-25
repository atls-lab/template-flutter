import 'package:built_collection/built_collection.dart';
import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class BuiltListTextAdapter extends TypeAdapter<BuiltList<UiText>> {
  @override
  BuiltList<UiText> read(BinaryReader reader) {
    return BuiltList<UiText>(reader.read());
  }

  @override
  final typeId = 8;

  @override
  void write(BinaryWriter writer, BuiltList<UiText> obj) {
    writer
      ..writeInt(obj.hashCode)
      ..writeBool(obj.isNotEmpty)
      ..writeBool(obj.isEmpty)
      ..write<UiText>(obj.first)
      ..write<UiText>(obj.last)
      ..writeInt(obj.length)
      ..write<UiText?>(obj.firstOrNull)
      ..write<Iterator<UiText>>(obj.iterator)
      ..write<Iterable<UiText>>(obj.reversed);
  }
}
