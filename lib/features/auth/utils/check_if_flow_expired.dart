import 'package:hive_flutter/hive_flutter.dart';

Future<void> checkIfFlowExpired(
    {required flow,
    required Function fallback,
    required Box<String>? flowBox,
    required String flowName}) async {
  if (flow == null) return;

  DateTime now = DateTime.now().toUtc();
  bool isValid = flow?.expiresAt.compareTo(now) > 0;

  if (isValid) return;

  flowBox?.delete(flowName);
  await fallback();
}
