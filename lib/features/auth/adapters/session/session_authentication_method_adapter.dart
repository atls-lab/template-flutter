import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class SessionAuthenticationMethodAdapter
    extends TypeAdapter<SessionAuthenticationMethod> {
  @override
  final typeId = 19;

  @override
  SessionAuthenticationMethod read(BinaryReader reader) {
    return (reader.read());
  }

  @override
  void write(BinaryWriter writer, SessionAuthenticationMethod obj) {
    writer
      ..write<SessionAuthenticationMethodMethodEnum?>(obj.method)
      ..write<DateTime?>(obj.completedAt);
  }
}
