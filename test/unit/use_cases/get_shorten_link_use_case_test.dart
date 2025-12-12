import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_shorten_links/modules/link_shortener/models/shorten_link.dart';
import 'package:nubank_shorten_links/modules/link_shortener/use_cases/get_shorten_link_use_case.dart';
import '../mocks/mock_shorten_link_repository.dart';

void main() {
  group('GetShortenLinkUseCase Unit Tests', () {
    late GetShortenLinkUseCaseImplement useCase;
    late MockShortenLinkRepository mockRepository;

    setUp(() {
      mockRepository = MockShortenLinkRepository();
      useCase = GetShortenLinkUseCaseImplement(shortenLinkRepository: mockRepository);
    });

    test('should return ShortenLink from repository', () async {
      final expectedLink = ShortenLink(
        alias: 'test-alias',
        originalUrl: 'https://example.com',
        shortUrl: 'https://short.ly/test-alias',
      );

      when(() => mockRepository.shortenLink(any())).thenAnswer((_) async => expectedLink);

      final result = await useCase.execute('https://example.com');

      expect(result.alias, equals(expectedLink.alias));
      expect(result.originalUrl, equals(expectedLink.originalUrl));
      expect(result.shortUrl, equals(expectedLink.shortUrl));
      verify(() => mockRepository.shortenLink('https://example.com')).called(1);
    });

    test('should propagate exception from repository', () async {
      when(() => mockRepository.shortenLink(any())).thenThrow(Exception('Erro de rede'));

      expect(() => useCase.execute('https://example.com'), throwsException);
      verify(() => mockRepository.shortenLink('https://example.com')).called(1);
    });
  });
}
