import 'package:built_collection/built_collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class BuiltListSessionAuthenticationMethodAdapter
    extends TypeAdapter<BuiltList<SessionAuthenticationMethod>> {
  @override
  final typeId = 21;

  @override
  BuiltList<SessionAuthenticationMethod> read(BinaryReader reader) {
    return (reader.read());
  }

  @override
  void write(BinaryWriter writer, BuiltList<SessionAuthenticationMethod> obj) {
    writer
      ..writeInt(obj.hashCode)
      ..writeBool(obj.isNotEmpty)
      ..writeBool(obj.isEmpty)
      ..write<SessionAuthenticationMethod>(obj.first)
      ..write<SessionAuthenticationMethod>(obj.last)
      ..writeInt(obj.length)
      ..write<SessionAuthenticationMethod?>(obj.firstOrNull)
      ..write<Iterator<SessionAuthenticationMethod>>(obj.iterator)
      ..write<Iterable<SessionAuthenticationMethod>>(obj.reversed);
  }
}
