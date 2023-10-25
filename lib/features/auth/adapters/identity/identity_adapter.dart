import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class IdentityAdapter extends TypeAdapter<Identity> {
  @override
  final typeId = 10;

  @override
  Identity read(BinaryReader reader) {
    return Identity(
      (b) => b
        ..id = reader.readString()
        ..state = reader.read()
        ..stateChangedAt = reader.read()
        ..updatedAt = reader.read()
        ..recoveryAddresses = reader.read()
        ..credentials = reader.read()
        ..createdAt = reader.read()
        ..verifiableAddresses = reader.read()
        ..traits = reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Identity obj) {
    writer
      ..writeString(obj.id)
      ..write<BuiltList<VerifiableIdentityAddress>?>(obj.verifiableAddresses)
      ..write<JsonObject?>(obj.traits)
      ..write<DateTime?>(obj.createdAt)
      ..write<BuiltMap<String, IdentityCredentials>?>(obj.credentials)
      ..write<BuiltList<RecoveryIdentityAddress>?>(obj.recoveryAddresses)
      ..write<DateTime?>(obj.updatedAt)
      ..write<DateTime?>(obj.stateChangedAt)
      ..write<IdentityState?>(obj.state);
  }
}
