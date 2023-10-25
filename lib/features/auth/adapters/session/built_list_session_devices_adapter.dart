import 'package:built_collection/built_collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class BuiltListSessionDeviceAdapter
    extends TypeAdapter<BuiltList<SessionDevice>> {
  @override
  final typeId = 23;

  @override
  BuiltList<SessionDevice> read(BinaryReader reader) {
    return (reader.read());
  }

  @override
  void write(BinaryWriter writer, BuiltList<SessionDevice> obj) {
    writer
      ..writeInt(obj.hashCode)
      ..writeBool(obj.isNotEmpty)
      ..writeBool(obj.isEmpty)
      ..write<SessionDevice>(obj.first)
      ..write<SessionDevice>(obj.last)
      ..writeInt(obj.length)
      ..write<SessionDevice?>(obj.firstOrNull)
      ..write<Iterator<SessionDevice>>(obj.iterator)
      ..write<Iterable<SessionDevice>>(obj.reversed);
  }
}
