import 'package:flutter_modular/flutter_modular.dart';

import 'stores/main.dart';

class DesignModule extends Module {
  static const String designRoute = '/design/';

  @override
  List<Bind> get binds => [Bind.lazySingleton((i) => ThemeStore(), export: true)];

  @override
  List<ModularRoute> get routes => [];
}
