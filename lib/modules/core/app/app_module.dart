import 'package:flutter_modular/flutter_modular.dart';
import '../config/main.dart';
import '../http/dio/api_http_service.dart';
import '../../design/design_module.dart';
import '../../link_shortener/link_shortener_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [DesignModule()];

  @override
  List<Bind> get binds => [Bind((i) => APIHttpService(baseUrl: Environment().config.apiBaseUrl))];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute<LinkShortenerModule>(LinkShortenerModule.shortenLinksViewRoute, module: LinkShortenerModule()),
    ModuleRoute<DesignModule>(DesignModule.designRoute, module: DesignModule()),
  ];
}
