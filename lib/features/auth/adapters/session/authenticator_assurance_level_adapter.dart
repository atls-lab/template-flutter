import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class AuthenticatorAssuranceLevelAdapter
    extends TypeAdapter<AuthenticatorAssuranceLevel> {
  @override
  final typeId = 18;

  @override
  AuthenticatorAssuranceLevel read(BinaryReader reader) {
    return (reader.read());
  }

  @override
  void write(BinaryWriter writer, AuthenticatorAssuranceLevel obj) {
    writer.writeString(obj.name);
  }
}
