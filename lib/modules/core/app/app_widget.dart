import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nubank_shorten_links/generated/l10n.dart';
import 'package:nubank_shorten_links/modules/core/config/environment.dart';
import 'package:nubank_shorten_links/modules/core/services/navigation.dart';
import 'package:nubank_shorten_links/modules/design/theme/theme.dart';
import 'package:nubank_shorten_links/modules/link_shortener/link_shortener_module.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(LinkShortenerModule.shortenLinksView);
    Modular.setNavigatorKey(NavigationService().navigatorKey);
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.unknown,
        },
      ),
      debugShowCheckedModeBanner: Environment().isProduction,
      supportedLocales: const <Locale>[
        Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
        Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      ],
      theme: DefaultTheme.getTheme(context),
      darkTheme: DarkTheme.getTheme(context),
      themeMode: ThemeMode.system,
      title: 'Nubank Shorten Links',
    );
  }
}
