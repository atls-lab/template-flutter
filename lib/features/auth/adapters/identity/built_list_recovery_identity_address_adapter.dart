import 'package:built_collection/built_collection.dart';
import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class BuiltListRecoveryAddressAdapter
    extends TypeAdapter<BuiltList<RecoveryIdentityAddress>> {
  @override
  BuiltList<RecoveryIdentityAddress> read(BinaryReader reader) {
    return BuiltList<RecoveryIdentityAddress>(reader.read());
  }

  @override
  final typeId = 15;

  @override
  void write(BinaryWriter writer, BuiltList<RecoveryIdentityAddress> obj) {
    writer
      ..writeInt(obj.hashCode)
      ..writeBool(obj.isNotEmpty)
      ..writeBool(obj.isEmpty)
      ..write<dynamic>(obj.first)
      ..write<dynamic>(obj.last)
      ..writeInt(obj.length)
      ..write(obj.firstOrNull);
  }
}
