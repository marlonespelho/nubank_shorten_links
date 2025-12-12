import 'package:flutter_modular/flutter_modular.dart';
import 'package:nubank_shorten_links/modules/core/config/main.dart';
import 'package:nubank_shorten_links/modules/core/http/dio/api_http_service.dart';
import 'package:nubank_shorten_links/modules/link_shortener/link_shortener_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [Bind((i) => APIHttpService(baseUrl: Environment().config.apiBaseUrl))];

  @override
  List<ModularRoute> get routes => [ModuleRoute(LinkShortenerModule.shortenLinksView, module: LinkShortenerModule())];
}
