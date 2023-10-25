import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hoh/app/router/app_router.dart';
import 'package:hoh/app/shared/shared.dart';

Future<void> main() async {
  GetIt.I.registerSingleton<AppRouter>(AppRouter());

  testWidgets('Main screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Button(props: ButtonProps(text: 'test')),
      ),
    ));

    expect(find.text('test'), findsOneWidget);
  });
}
