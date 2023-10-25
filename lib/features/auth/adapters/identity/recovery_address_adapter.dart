import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class RecoveryAddressAdapter extends TypeAdapter<RecoveryIdentityAddress> {
  @override
  final typeId = 16;

  @override
  RecoveryIdentityAddress read(BinaryReader reader) {
    return RecoveryIdentityAddress(reader.read());
  }

  @override
  void write(BinaryWriter writer, RecoveryIdentityAddress obj) {
    writer
      ..writeString(obj.id)
      ..write(obj.createdAt)
      ..write(obj.updatedAt)
      ..writeString(obj.value)
      ..writeString(obj.via);
  }
}
