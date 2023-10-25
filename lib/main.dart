import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'app/application.dart';
import 'app/hive/hive.dart';
import 'app/router/app_router.dart';

Future<void> main() async {
  const String environment =
      String.fromEnvironment('MODE', defaultValue: 'DEV');
  String envFileName;

  switch (environment) {
    case 'STAGE':
      envFileName = '.env/.stage.env';
    case 'PROD':
      envFileName = '.env/.prod.env';
    default:
      envFileName = '.env/.dev.env';
  }

  await dotenv.load(fileName: envFileName);

  HiveApp hive = HiveApp();
  await hive.initHive();
  await hive.openBoxes();

  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton<AppRouter>(AppRouter());

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const Application());
  });
}
