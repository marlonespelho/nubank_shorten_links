import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nubank_shorten_links/modules/core/app/app_core.dart';

import 'modules/core/config/system.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await System().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(const AppCore());
}
