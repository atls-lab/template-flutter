import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class RegistrationFlowAdapter extends TypeAdapter<RegistrationFlow> {
  @override
  RegistrationFlow read(BinaryReader reader) {
    return (reader.read());
  }

  @override
  final typeId = 1;

  @override
  void write(BinaryWriter writer, RegistrationFlow obj) {
    writer
      ..writeString(obj.id)
      ..write<DateTime>(obj.expiresAt)
      ..write<IdentityCredentialsType?>(obj.active)
      ..write<DateTime>(obj.issuedAt)
      ..writeString(obj.requestUrl)
      ..writeInt(obj.hashCode)
      ..writeString(obj.type)
      ..write<String?>(obj.returnTo);
  }
}
