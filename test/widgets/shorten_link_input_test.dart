import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_shorten_links/generated/l10n.dart';
import 'package:nubank_shorten_links/modules/link_shortener/views/shorten_links_view/widgets/shorten_link_input.dart';

void main() {
  group('ShortenLinkInput Widget Tests', () {
    late TextEditingController linkController;
    late bool isLoading;
    late bool Function(String) validateUrl;
    late ValueChanged<String> onFieldSubmitted;
    late int onFieldSubmittedCallCount;
    late String lastSubmittedValue;

    setUp(() {
      linkController = TextEditingController();
      isLoading = false;
      onFieldSubmittedCallCount = 0;
      lastSubmittedValue = '';

      validateUrl = (String value) {
        final regex = RegExp(r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$');
        return regex.hasMatch(value);
      };

      onFieldSubmitted = (String value) {
        onFieldSubmittedCallCount++;
        lastSubmittedValue = value;
      };
    });

    tearDown(() {
      linkController.dispose();
    });

    Widget createTestWidget() {
      return MaterialApp(
        localizationsDelegates: const [S.delegate],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          body: ShortenLinkInput(
            linkController: linkController,
            isLoading: isLoading,
            validateUrl: validateUrl,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ),
      );
    }

    testWidgets('should render text field and button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byIcon(Icons.send), findsOneWidget);
    });

    testWidgets('should disable field when isLoading is true', (WidgetTester tester) async {
      isLoading = true;
      await tester.pumpWidget(createTestWidget());

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('should enable field when isLoading is false', (WidgetTester tester) async {
      isLoading = false;
      await tester.pumpWidget(createTestWidget());

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, isTrue);
    });

    testWidgets('should show CircularProgressIndicator when isLoading is true', (WidgetTester tester) async {
      isLoading = true;
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.send), findsNothing);
    });

    testWidgets('should call onFieldSubmitted when text is submitted', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(find.byType(TextFormField), 'https://example.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(onFieldSubmittedCallCount, equals(1));
      expect(lastSubmittedValue, equals('https://example.com'));
    });

    testWidgets('should call onFieldSubmitted when button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(find.byType(TextFormField), 'https://example.com');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(onFieldSubmittedCallCount, equals(1));
      expect(lastSubmittedValue, equals('https://example.com'));
    });

    testWidgets('should validate URL correctly', (WidgetTester tester) async {
      final form = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [S.delegate],
          supportedLocales: S.delegate.supportedLocales,
          home: Scaffold(
            body: Form(
              key: form,
              child: ShortenLinkInput(
                linkController: linkController,
                isLoading: isLoading,
                validateUrl: validateUrl,
                onFieldSubmitted: onFieldSubmitted,
              ),
            ),
          ),
        ),
      );

      final formField = tester.widget<TextFormField>(find.byType(TextFormField));
      final validator = formField.validator;

      // Test with valid URL
      expect(validator?.call('https://example.com'), isNull);

      expect(validator?.call('url-invalida'), isNotNull);
    });

    testWidgets('should not call onFieldSubmitted when button is disabled', (WidgetTester tester) async {
      isLoading = true;
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(find.byType(TextFormField), 'https://example.com');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(onFieldSubmittedCallCount, equals(0));
    });
  });
}
