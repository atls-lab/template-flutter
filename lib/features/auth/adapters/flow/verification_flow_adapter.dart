import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class VerificationFlowAdapter extends TypeAdapter<VerificationFlow> {
  @override
  VerificationFlow read(BinaryReader reader) {
    return VerificationFlow(reader.read());
  }

  @override
  final typeId = 3;

  @override
  void write(BinaryWriter writer, VerificationFlow obj) {
    writer
      ..writeString(obj.id)
      ..write<DateTime?>(obj.expiresAt)
      ..write<String?>(obj.active)
      ..write<DateTime?>(obj.issuedAt)
      ..writeInt(obj.hashCode)
      ..writeString(obj.type)
      ..write<String?>(obj.returnTo);
  }
}
