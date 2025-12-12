import '../models/main.dart';

abstract interface class ShortenLinkRepositoryContract {
  Future<ShortenLink> shortenLink(String link);
}
