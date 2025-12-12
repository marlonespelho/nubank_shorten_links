import '../../core/http/http_service.dart';
import '../models/main.dart';
import 'shorten_link_repository_contract.dart';

class DefaultLinkRepositoryImplement implements ShortenLinkRepositoryContract {
  DefaultLinkRepositoryImplement({required this.httpClient});
  final HttpService httpClient;
  @override
  Future<ShortenLink> shortenLink(String link) async {
    final response = await httpClient.post<Map<String, dynamic>>(path: '/alias', data: {'url': link});
    return ShortenLink.fromJson(response as Map<String, dynamic>);
  }
}
