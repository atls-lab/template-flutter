import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/adapters/auth_adapters_registrar.dart';

class HiveApp {
  HiveApp() {
    AuthAdaptersRegistrar.registerSessionAdapters();
    AuthAdaptersRegistrar.registerIdentityAdapters();
    AuthAdaptersRegistrar.registerGeneralAdapters();
  }

  Future<void> initHive() async {
    await Hive.initFlutter();
  }

  Future<void> openBoxes() async {
    await Hive.openBox('session');
    await Hive.openBox<String>('flow');
  }
}
