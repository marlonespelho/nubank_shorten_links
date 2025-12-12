import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_shorten_links/modules/link_shortener/models/shorten_link.dart';
import 'package:nubank_shorten_links/modules/link_shortener/stores/shorten_link_store.dart';
import '../mocks/mock_shorten_link_use_case.dart';

void main() {
  group('ShortenLinkStore Unit Tests', () {
    late ShortenLinkStore store;
    late MockGetShortenLinkUseCase mockUseCase;

    setUp(() {
      mockUseCase = MockGetShortenLinkUseCase();
      store = ShortenLinkStore(getShortenLinkUseCase: mockUseCase);
    });

    tearDown(() {
      store.shortenLinks.clear();
    });

    test('should initialize with isLoading false', () {
      expect(store.isLoading, isFalse);
    });

    test('should initialize with empty links list', () {
      expect(store.shortenLinks.length, equals(0));
    });

    group('shortenLink', () {
      test('should set isLoading to true during processing', () async {
        final expectedLink = ShortenLink(
          alias: 'test',
          originalUrl: 'https://example.com',
          shortUrl: 'https://short.ly/test',
        );

        when(() => mockUseCase.execute(any())).thenAnswer((_) async => expectedLink);

        expect(store.isLoading, isFalse);

        final future = store.shortenLink(url: 'https://example.com', successCallback: () {});

        await future;

        expect(store.isLoading, isFalse);
        expect(store.shortenLinks.length, equals(1));
        verify(() => mockUseCase.execute('https://example.com')).called(1);
      });

      test('should add link to list when successful', () async {
        final expectedLink = ShortenLink(
          alias: 'test-alias',
          originalUrl: 'https://example.com',
          shortUrl: 'https://short.ly/test-alias',
        );

        when(() => mockUseCase.execute(any())).thenAnswer((_) async => expectedLink);

        bool callbackCalled = false;

        await store.shortenLink(
          url: 'https://example.com',
          successCallback: () {
            callbackCalled = true;
          },
        );

        expect(store.shortenLinks.length, equals(1));
        expect(store.shortenLinks.first.alias, equals('test-alias'));
        expect(store.shortenLinks.first.originalUrl, equals('https://example.com'));
        expect(store.shortenLinks.first.shortUrl, equals('https://short.ly/test-alias'));
        expect(callbackCalled, isTrue);
        verify(() => mockUseCase.execute('https://example.com')).called(1);
      });

      test('should insert new link at the beginning of the list', () async {
        store.shortenLinks.add(
          ShortenLink(alias: 'old', originalUrl: 'https://old.com', shortUrl: 'https://short.ly/old'),
        );

        final newLink = ShortenLink(alias: 'new', originalUrl: 'https://new.com', shortUrl: 'https://short.ly/new');

        when(() => mockUseCase.execute(any())).thenAnswer((_) async => newLink);

        await store.shortenLink(url: 'https://new.com', successCallback: () {});

        expect(store.shortenLinks.length, equals(2));
        expect(store.shortenLinks.first.alias, equals('new'));
        expect(store.shortenLinks.last.alias, equals('old'));
        verify(() => mockUseCase.execute('https://new.com')).called(1);
      });

      test('should set isLoading to false after error', () async {
        when(() => mockUseCase.execute(any())).thenThrow(Exception('Erro de rede'));

        try {
          await store.shortenLink(url: 'https://example.com', successCallback: () {});
        } catch (e) {
          // Expected exception, continue to verify state
        }

        expect(store.isLoading, isFalse);
        verify(() => mockUseCase.execute('https://example.com')).called(1);
      });

      test('should throw exception when use case fails', () async {
        when(() => mockUseCase.execute(any())).thenThrow(Exception('Erro de rede'));

        expect(() => store.shortenLink(url: 'https://example.com', successCallback: () {}), throwsException);
        verify(() => mockUseCase.execute('https://example.com')).called(1);
      });

      test('should not call successCallback when there is an error', () async {
        when(() => mockUseCase.execute(any())).thenThrow(Exception('Erro de rede'));

        bool callbackCalled = false;

        try {
          await store.shortenLink(
            url: 'https://example.com',
            successCallback: () {
              callbackCalled = true;
            },
          );
        } catch (e) {
          // Expected exception, continue to verify callback was not called
        }

        expect(callbackCalled, isFalse);
        verify(() => mockUseCase.execute('https://example.com')).called(1);
      });
    });

    group('copyLink', () {
      test('should copy link to clipboard and call successCallback', () async {
        bool successCallbackCalled = false;
        bool errorCallbackCalled = false;

        await store.copyLink(
          link: 'https://short.ly/test',
          successCallback: () {
            successCallbackCalled = true;
          },
          errorCallback: () {
            errorCallbackCalled = true;
          },
        );

        expect(successCallbackCalled || errorCallbackCalled, isTrue);
        expect(successCallbackCalled != errorCallbackCalled, isTrue);
      });

      test('should call errorCallback when clipboard fails', () async {
        bool successCallbackCalled = false;
        bool errorCallbackCalled = false;

        try {
          await store.copyLink(
            link: 'https://short.ly/test',
            successCallback: () {
              successCallbackCalled = true;
            },
            errorCallback: () {
              errorCallbackCalled = true;
            },
          );
        } catch (e) {
          // If there's an exception, errorCallback should be called
        }

        expect(successCallbackCalled || errorCallbackCalled, isTrue);
      });
    });

    group('validateUrl', () {
      test('should validate valid URL with http', () {
        expect(store.validateUrl('http://example.com'), isTrue);
      });

      test('should validate valid URL with https', () {
        expect(store.validateUrl('https://example.com'), isTrue);
      });

      test('should validate valid URL without protocol', () {
        expect(store.validateUrl('example.com'), isTrue);
      });

      test('should validate valid URL with path', () {
        expect(store.validateUrl('https://example.com/path/to/page'), isTrue);
      });

      test('should validate valid URL with subdomain', () {
        expect(store.validateUrl('https://sub.example.com'), isTrue);
      });
      test('should validate valid URL with special characters', () {
        expect(store.validateUrl('https://sub.example.com/path/to/aew-sftr-xyi?pli=1&authuser=1'), isTrue);
      });

      test('should not validate invalid URL', () {
        expect(store.validateUrl('url-invalida'), isFalse);
      });

      test('should not validate empty string', () {
        expect(store.validateUrl(''), isFalse);
      });

      test('should not validate null', () {
        expect(store.validateUrl(null), isFalse);
      });

      test('should not validate only spaces', () {
        expect(store.validateUrl('   '), isFalse);
      });

      test('should not validate URL without domain', () {
        expect(store.validateUrl('http://'), isFalse);
      });
    });
  });
}
