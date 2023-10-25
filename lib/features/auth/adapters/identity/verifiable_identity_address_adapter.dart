import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class VerifiableIdentityAddressAdapter
    extends TypeAdapter<VerifiableIdentityAddress> {
  @override
  final typeId = 11;

  @override
  VerifiableIdentityAddress read(BinaryReader reader) {
    return VerifiableIdentityAddress(reader.read());
  }

  @override
  void write(BinaryWriter writer, VerifiableIdentityAddress obj) {
    writer
      ..write<String?>(obj.id)
      ..write<DateTime?>(obj.createdAt)
      ..write<DateTime?>(obj.updatedAt)
      ..writeString(obj.status)
      ..writeString(obj.value)
      ..writeBool(obj.verified)
      ..writeString(obj.via)
      ..write<DateTime?>(obj.verifiedAt);
  }
}
