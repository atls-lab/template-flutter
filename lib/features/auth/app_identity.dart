import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

@HiveType(typeId: 25)
class AppIdentity {
  @HiveField(0)
  DateTime? createdAt;
  @HiveField(1)
  late String id;
  @HiveField(2)
  List<RecoveryIdentityAddress>? recoveryAddresses;
  @HiveField(3)
  late String schemaId;
  @HiveField(4)
  late String schemaUrl;
  @HiveField(5)
  String? state;
  @HiveField(6)
  DateTime? stateChangedAt;
  @HiveField(7)
  Map<dynamic, dynamic>? traits;
  @HiveField(8)
  DateTime? updatedAt;
  @HiveField(9)
  List<VerifiableIdentityAddress>? verifiableAddresses;

  AppIdentity(Identity? identity) {
    createdAt = identity?.createdAt;
    id = identity?.id ?? '';
    recoveryAddresses = identity?.recoveryAddresses?.toList();
    schemaId = identity?.schemaId ?? '';
    schemaUrl = identity?.schemaUrl ?? '';
    state = identity?.state?.name;
    stateChangedAt = identity?.stateChangedAt;
    traits = identity?.traits?.asMap;
    updatedAt = identity?.updatedAt;
    verifiableAddresses = identity?.verifiableAddresses?.toList();
  }
}
