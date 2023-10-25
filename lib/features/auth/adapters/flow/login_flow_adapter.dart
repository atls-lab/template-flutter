import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class LoginFlowAdapter extends TypeAdapter<LoginFlow> {
  @override
  LoginFlow read(BinaryReader reader) {
    return LoginFlow(reader.read());
  }

  @override
  final typeId = 2;

  @override
  void write(BinaryWriter writer, LoginFlow obj) {
    writer.writeString(obj.id);
    writer.write<DateTime?>(obj.expiresAt);
    writer.write<IdentityCredentialsType?>(obj.active);
    writer.write<DateTime?>(obj.issuedAt);
    writer.writeString(obj.requestUrl);
    writer.writeInt(obj.hashCode);
    writer.writeString(obj.type);
    writer.write<String?>(obj.returnTo);
  }
}
