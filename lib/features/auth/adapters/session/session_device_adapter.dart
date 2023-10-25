import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class SessionDeviceAdapter extends TypeAdapter<SessionDevice> {
  @override
  final typeId = 24;

  @override
  SessionDevice read(BinaryReader reader) {
    return (reader.read());
  }

  @override
  void write(BinaryWriter writer, SessionDevice obj) {
    writer
      ..writeString(obj.id)
      ..write<String?>(obj.ipAddress)
      ..write<String?>(obj.userAgent)
      ..write<String?>(obj.location);
  }
}
