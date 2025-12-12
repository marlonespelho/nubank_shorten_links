import 'package:flutter_modular/flutter_modular.dart';
import 'package:nubank_shorten_links/modules/link_shortener/views/shorten_links_view/main.dart';

class LinkShortenerModule extends Module {
  static const String shortenLinksView = '/shorten-links';

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [ChildRoute('/', child: (context, args) => const ShortenLinksView())];
}
