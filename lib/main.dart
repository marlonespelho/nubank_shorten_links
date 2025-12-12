import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'modules/core/app/app_core.dart';

import 'modules/core/config/system.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await System().init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(const AppCore());
}
