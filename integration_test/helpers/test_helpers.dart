import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_shorten_links/modules/core/config/system.dart';
import 'package:nubank_shorten_links/modules/core/app/app_core.dart';

Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await System().init();
  runApp(DefaultAssetBundle(bundle: TestAssetBundle(), child: const AppCore()));
}

Future<void> closeSnackBar(WidgetTester tester) async {
  final snackBar = find.byKey(const Key('snackBarMessage'));
  bool snackBarClosed = false;

  if (snackBar.evaluate().isNotEmpty) {
    final closeIcon = find.descendant(of: snackBar, matching: find.byIcon(Icons.close));

    if (closeIcon.evaluate().isNotEmpty) {
      await tester.tap(closeIcon, warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      snackBarClosed = true;
    }
  }

  if (!snackBarClosed && snackBar.evaluate().isNotEmpty) {
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
  } else {
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
  }
}

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async =>
      utf8.decode((await load(key)).buffer.asUint8List());

  @override
  Future<ByteData> load(String key) async => rootBundle.load(key);
}
