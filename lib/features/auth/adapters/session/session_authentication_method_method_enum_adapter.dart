import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class SessionAuthenticationMethodMethodEnumAdapter
    extends TypeAdapter<SessionAuthenticationMethodMethodEnum> {
  @override
  final typeId = 20;

  @override
  SessionAuthenticationMethodMethodEnum read(BinaryReader reader) {
    return (reader.read());
  }

  @override
  void write(BinaryWriter writer, SessionAuthenticationMethodMethodEnum obj) {
    writer.writeString(obj.name);
  }
}
