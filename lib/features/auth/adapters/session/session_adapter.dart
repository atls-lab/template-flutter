import 'package:built_collection/built_collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final typeId = 0;

  @override
  read(BinaryReader reader) {
    return reader.read();
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..write<Identity>(obj.identity)
      ..writeString(obj.id)
      ..write<DateTime?>(obj.expiresAt)
      ..write<bool?>(obj.active)
      ..write<DateTime?>(obj.issuedAt)
      ..write<BuiltList<SessionDevice>?>(obj.devices)
      ..write<DateTime?>(obj.authenticatedAt);
  }
}
