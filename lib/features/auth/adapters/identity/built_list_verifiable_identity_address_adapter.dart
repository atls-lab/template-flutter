import 'package:built_collection/built_collection.dart';
import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class BuiltListVerifiableIdentityAddressAdapter
    extends TypeAdapter<BuiltList<VerifiableIdentityAddress>> {
  @override
  BuiltList<VerifiableIdentityAddress> read(BinaryReader reader) {
    return BuiltList<VerifiableIdentityAddress>(reader.read());
  }

  @override
  final typeId = 13;

  @override
  void write(BinaryWriter writer, BuiltList<VerifiableIdentityAddress> obj) {
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
