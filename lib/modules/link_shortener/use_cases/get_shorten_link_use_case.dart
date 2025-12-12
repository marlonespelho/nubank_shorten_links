import '../../core/protocols/main.dart';
import '../models/main.dart';
import '../repositories/shorten_link_repository_contract.dart';

abstract interface class GetShortenLinkUseCaseContract implements UseCase<ShortenLink, String> {}

class GetShortenLinkUseCaseImplement implements GetShortenLinkUseCaseContract {
  GetShortenLinkUseCaseImplement({required this.shortenLinkRepository});
  final ShortenLinkRepositoryContract shortenLinkRepository;

  @override
  Future<ShortenLink> execute(String link) async {
    return shortenLinkRepository.shortenLink(link);
  }
}
