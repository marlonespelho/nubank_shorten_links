import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'helpers/test_helpers.dart';
import 'package:nubank_shorten_links/modules/link_shortener/views/shorten_links_view/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Copy Link Tests', () {
    testWidgets('should copy link in history list to clipboard ', (WidgetTester tester) async {
      await startApp();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      expect(find.byType(ShortenLinksView), findsOneWidget);

      final textField = find.byKey(const Key('shortenLinkTextField'));
      expect(textField, findsOneWidget);

      final sendButton = find.byKey(const Key('shortenLinkButton'));
      expect(sendButton, findsOneWidget);

      await tester.enterText(textField, 'https://www.nubank.com.br');
      await tester.pumpAndSettle();

      await tester.tap(sendButton);
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      var copyButtons = find.byIcon(Icons.copy);
      expect(copyButtons, findsAtLeastNWidgets(1));

      await tester.pump(const Duration(milliseconds: 800));
      await tester.pumpAndSettle();

      await closeSnackBar(tester);

      await tester.tap(textField);
      await tester.pumpAndSettle();

      await tester.enterText(textField, 'https://www.google.com');
      await tester.pumpAndSettle();

      await tester.tap(sendButton);
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      final cards = find.byType(Card);
      expect(cards, findsAtLeastNWidgets(2));

      copyButtons = find.byIcon(Icons.copy);
      expect(copyButtons, findsAtLeastNWidgets(2));

      final listView = find.byType(ListView);
      if (listView.evaluate().isNotEmpty) {
        await tester.drag(listView, const Offset(0, -300));
        await tester.pumpAndSettle();
      }

      final allCopyButtons = find.byIcon(Icons.copy);
      expect(allCopyButtons, findsAtLeastNWidgets(2));

      await tester.tap(allCopyButtons.last, warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));
    });
  });
}
