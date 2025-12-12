import 'dart:async';

import 'environment.dart';

class System {
  factory System() => _instance;

  System._internal() {
    _preInit();
  }
  static final System _instance = System._internal();

  bool isReady = false;

  Future<void> _preInit() async {}

  Future<void> init() async {
    if (isReady) {
      return;
    }

    _initEnvironment();

    isReady = true;
  }

  void _initEnvironment() => Environment().initConfig();
}
