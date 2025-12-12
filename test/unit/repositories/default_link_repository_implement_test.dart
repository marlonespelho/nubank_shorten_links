import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_shorten_links/modules/link_shortener/models/shorten_link.dart';
import 'package:nubank_shorten_links/modules/link_shortener/repositories/default_link_repository_implement.dart';
import '../mocks/mock_http_service.dart';

void main() {
  group('DefaultLinkRepositoryImplement Unit Tests', () {
    late DefaultLinkRepositoryImplement repository;
    late MockHttpService mockHttpService;

    setUp(() {
      mockHttpService = MockHttpService();
      repository = DefaultLinkRepositoryImplement(httpClient: mockHttpService);
    });

    test('should call httpClient.post with correct path', () async {
      const testUrl = 'https://example.com';
      final responseJson = {
        'alias': 'test-alias',
        '_links': {'self': testUrl, 'short': 'https://short.ly/test-alias'},
      };

      when(
        () => mockHttpService.post<Map<String, dynamic>>(
          path: any<String>(named: 'path'),
          data: any<Map<String, dynamic>>(named: 'data'),
          queryParams: any<Map<String, dynamic>?>(named: 'queryParams'),
          onError: any<void Function(Object)?>(named: 'onError'),
        ),
      ).thenAnswer((invocation) async {
        final data = invocation.namedArguments[#data] as Map<String, dynamic>?;
        expect(data?['url'], equals(testUrl));
        expect(invocation.namedArguments[#path], equals('/alias'));
        return responseJson;
      });

      await repository.shortenLink(testUrl);

      verify(
        () => mockHttpService.post<Map<String, dynamic>>(
          path: '/alias',
          data: {'url': testUrl},
          queryParams: any<Map<String, dynamic>?>(named: 'queryParams'),
          onError: any<void Function(Object)?>(named: 'onError'),
        ),
      ).called(1);
    });

    test('should return ShortenLink when HTTP returns success', () async {
      const testUrl = 'https://example.com';
      final expectedJson = {
        'alias': 'test-alias',
        '_links': {'self': testUrl, 'short': 'https://short.ly/test-alias'},
      };

      when(
        () => mockHttpService.post<Map<String, dynamic>>(
          path: any<String>(named: 'path'),
          data: any<Map<String, dynamic>>(named: 'data'),
          queryParams: any<Map<String, dynamic>?>(named: 'queryParams'),
          onError: any<void Function(Object)?>(named: 'onError'),
        ),
      ).thenAnswer((_) async => expectedJson);

      final result = await repository.shortenLink(testUrl);

      expect(result, isA<ShortenLink>());
      expect(result.alias, equals('test-alias'));
      expect(result.originalUrl, equals(testUrl));
      expect(result.shortUrl, equals('https://short.ly/test-alias'));
    });

    test('should propagate exception from httpClient', () async {
      when(
        () => mockHttpService.post<Map<String, dynamic>>(
          path: any<String>(named: 'path'),
          data: any<Map<String, dynamic>>(named: 'data'),
          queryParams: any<Map<String, dynamic>?>(named: 'queryParams'),
          onError: any<void Function(Object)?>(named: 'onError'),
        ),
      ).thenThrow(Exception('Erro de rede'));

      expect(() => repository.shortenLink('https://example.com'), throwsException);
    });
  });
}
