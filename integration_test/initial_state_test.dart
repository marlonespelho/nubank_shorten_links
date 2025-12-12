import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'helpers/test_helpers.dart';
import 'package:nubank_shorten_links/modules/link_shortener/views/shorten_links_view/main.dart';
import 'package:nubank_shorten_links/modules/link_shortener/views/shorten_links_view/widgets/shorten_link_input.dart';
import 'package:nubank_shorten_links/modules/link_shortener/views/shorten_links_view/widgets/shortened_links_list.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Initial State Tests', () {
    testWidgets('should open shorten links page and show initial state', (WidgetTester tester) async {
      await startApp();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      expect(find.byType(ShortenLinksView), findsOneWidget);
      expect(find.byType(ShortenLinkInput), findsOneWidget);
      expect(find.byType(ShortenedLinksList), findsOneWidget);
    });
  });
}
