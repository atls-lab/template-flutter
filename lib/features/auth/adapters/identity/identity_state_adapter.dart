import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class IdentityStateAdapter extends TypeAdapter<IdentityState> {
  @override
  final typeId = 17;

  @override
  IdentityState read(BinaryReader reader) {
    return (reader.read());
  }

  @override
  void write(BinaryWriter writer, IdentityState obj) {
    writer.writeString(obj.name);
  }
}
