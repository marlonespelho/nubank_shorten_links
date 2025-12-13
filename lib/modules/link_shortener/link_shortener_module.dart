import 'package:flutter_modular/flutter_modular.dart';
import '../core/http/main.dart';
import 'repositories/default_link_repository_implement.dart';
import 'stores/main.dart';
import 'use_cases/main.dart';
import 'views/shorten_links_view/main.dart';

class LinkShortenerModule extends Module {
  static const String shortenLinksViewRoute = '/shorten-links/';

  @override
  List<Bind> get binds => [
    Bind((i) => DefaultLinkRepositoryImplement(httpClient: i.get<APIHttpService>())),
    Bind((i) => GetShortenLinkUseCaseImplement(shortenLinkRepository: i.get<DefaultLinkRepositoryImplement>())),
    Bind((i) => ShortenLinkStore(getShortenLinkUseCase: i.get<GetShortenLinkUseCaseImplement>())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute<ShortenLinksView>('/', child: (context, args) => const ShortenLinksView()),
  ];
}
