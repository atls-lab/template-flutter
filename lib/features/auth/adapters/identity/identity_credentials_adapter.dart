import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class IdentityCredentialsAdapter extends TypeAdapter<IdentityCredentials> {
  @override
  final typeId = 12;

  @override
  IdentityCredentials read(BinaryReader reader) {
    return IdentityCredentials(reader.read());
  }

  @override
  void write(BinaryWriter writer, IdentityCredentials obj) {
    writer
      ..write<DateTime?>(obj.createdAt)
      ..write<DateTime?>(obj.updatedAt)
      ..write<BuiltList<String>?>(obj.identifiers)
      ..write<JsonObject?>(obj.config)
      ..write<int?>(obj.version);
  }
}
