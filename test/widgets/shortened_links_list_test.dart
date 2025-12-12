import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_shorten_links/generated/l10n.dart';
import 'package:nubank_shorten_links/modules/link_shortener/models/shorten_link.dart';
import 'package:nubank_shorten_links/modules/link_shortener/views/shorten_links_view/widgets/shortened_links_list.dart';

void main() {
  group('ShortenedLinksList Widget Tests', () {
    late List<ShortenLink> shortenLinks;
    late List<String> copiedLinks;
    late ValueChanged<String> onCopyLink;

    setUp(() {
      copiedLinks = [];
      onCopyLink = (String link) {
        copiedLinks.add(link);
      };
    });

    Widget createTestWidget() {
      return MaterialApp(
        localizationsDelegates: const [S.delegate],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          body: ShortenedLinksList(shortenLinks: shortenLinks, onCopyLink: onCopyLink),
        ),
      );
    }

    testWidgets('should show message when list is empty', (WidgetTester tester) async {
      shortenLinks = [];
      await tester.pumpWidget(createTestWidget());

      expect(find.text('No shorten links found'), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('should render list when there are links', (WidgetTester tester) async {
      shortenLinks = [
        ShortenLink(alias: 'test1', originalUrl: 'https://example.com', shortUrl: 'https://short.ly/test1'),
        ShortenLink(alias: 'test2', originalUrl: 'https://google.com', shortUrl: 'https://short.ly/test2'),
      ];

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Shortened links history'), findsOneWidget);
      expect(find.text('https://short.ly/test1'), findsOneWidget);
      expect(find.text('https://example.com'), findsOneWidget);
      expect(find.text('https://short.ly/test2'), findsOneWidget);
      expect(find.text('https://google.com'), findsOneWidget);
    });

    testWidgets('should render cards for each link', (WidgetTester tester) async {
      shortenLinks = [
        ShortenLink(alias: 'test1', originalUrl: 'https://example.com', shortUrl: 'https://short.ly/test1'),
      ];

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should call onCopyLink when copy button is pressed', (WidgetTester tester) async {
      shortenLinks = [
        ShortenLink(alias: 'test1', originalUrl: 'https://example.com', shortUrl: 'https://short.ly/test1'),
      ];

      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.copy), findsOneWidget);

      await tester.tap(find.byIcon(Icons.copy));
      await tester.pump();

      expect(copiedLinks.length, equals(1));
      expect(copiedLinks.first, equals('https://short.ly/test1'));
    });

    testWidgets('should render multiple links correctly', (WidgetTester tester) async {
      shortenLinks = [
        ShortenLink(alias: 'test1', originalUrl: 'https://example.com', shortUrl: 'https://short.ly/test1'),
        ShortenLink(alias: 'test2', originalUrl: 'https://google.com', shortUrl: 'https://short.ly/test2'),
        ShortenLink(alias: 'test3', originalUrl: 'https://github.com', shortUrl: 'https://short.ly/test3'),
      ];

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Card), findsNWidgets(3));
      expect(find.byType(ListTile), findsNWidgets(3));
      expect(find.byIcon(Icons.copy), findsNWidgets(3));
    });

    testWidgets('should copy correct link when multiple links are present', (WidgetTester tester) async {
      shortenLinks = [
        ShortenLink(alias: 'test1', originalUrl: 'https://example.com', shortUrl: 'https://short.ly/test1'),
        ShortenLink(alias: 'test2', originalUrl: 'https://google.com', shortUrl: 'https://short.ly/test2'),
      ];

      await tester.pumpWidget(createTestWidget());

      final copyButtons = find.byIcon(Icons.copy);
      expect(copyButtons, findsNWidgets(2));

      await tester.tap(copyButtons.first);
      await tester.pump();

      expect(copiedLinks.length, equals(1));
      expect(copiedLinks.first, equals('https://short.ly/test1'));

      await tester.tap(copyButtons.at(1));
      await tester.pump();

      expect(copiedLinks.length, equals(2));
      expect(copiedLinks.last, equals('https://short.ly/test2'));
    });
  });
}
