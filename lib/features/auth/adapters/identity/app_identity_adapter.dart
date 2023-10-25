import 'package:hive_flutter/hive_flutter.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

import '../../app_identity.dart';

class AppIdentityAdapter extends TypeAdapter<AppIdentity> {
  @override
  final int typeId = 25;

  @override
  AppIdentity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppIdentity(reader.read())
      ..createdAt = fields[0] as DateTime?
      ..id = fields[1] as String
      ..recoveryAddresses =
          (fields[2] as List?)?.cast<RecoveryIdentityAddress>()
      ..schemaId = fields[3] as String
      ..schemaUrl = fields[4] as String
      ..state = fields[5] as String?
      ..stateChangedAt = fields[6] as DateTime?
      ..traits = (fields[7] as Map?)?.cast<dynamic, dynamic>()
      ..updatedAt = fields[8] as DateTime?
      ..verifiableAddresses =
          (fields[9] as List?)?.cast<VerifiableIdentityAddress>();
  }

  @override
  void write(BinaryWriter writer, AppIdentity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.recoveryAddresses)
      ..writeByte(3)
      ..write(obj.schemaId)
      ..writeByte(4)
      ..write(obj.schemaUrl)
      ..writeByte(5)
      ..write(obj.state)
      ..writeByte(6)
      ..write(obj.stateChangedAt)
      ..writeByte(7)
      ..write(obj.traits)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.verifiableAddresses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppIdentityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
