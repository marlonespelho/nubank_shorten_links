import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'helpers/test_helpers.dart';
import 'package:nubank_shorten_links/modules/link_shortener/views/shorten_links_view/main.dart';
import 'package:nubank_shorten_links/modules/link_shortener/views/shorten_links_view/widgets/shorten_link_input.dart';
import 'package:nubank_shorten_links/modules/link_shortener/views/shorten_links_view/widgets/shortened_links_list.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Shorten Link Tests', () {
    testWidgets('should shorten a link and add it to the list', (WidgetTester tester) async {
      await startApp();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      expect(find.byType(ShortenLinksView), findsOneWidget);
      expect(find.byType(ShortenLinkInput), findsOneWidget);

      final textField = find.byKey(const Key('shortenLinkTextField'));
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'https://www.google.com');
      await tester.pumpAndSettle();

      final sendButton = find.byKey(const Key('shortenLinkButton'));
      expect(sendButton, findsOneWidget);

      await tester.tap(sendButton);
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(find.byType(ShortenedLinksList), findsOneWidget);

      final cards = find.byType(Card);
      expect(cards, findsWidgets);
    });
  });
}
