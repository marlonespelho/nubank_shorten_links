import 'dart:async';

import 'package:nubank_shorten_links/modules/core/config/environment.dart';

class System {
  static final System _instance = System._internal();

  factory System() => _instance;

  bool isReady = false;

  System._internal() {
    _preInit();
  }

  void _preInit() async {}

  Future init() async {
    if (isReady) {
      return;
    }

    _initEnvironment();

    isReady = true;
  }

  void _initEnvironment() => Environment().initConfig();
}
