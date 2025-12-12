import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../generated/l10n.dart';
import '../config/environment.dart';
import '../services/navigation.dart';
import '../../design/stores/theme_store.dart';
import '../../design/theme/theme.dart';
import '../../link_shortener/link_shortener_module.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeStore themeStore = Modular.get<ThemeStore>();
    Modular.setInitialRoute(LinkShortenerModule.shortenLinksViewRoute);
    Modular.setNavigatorKey(NavigationService().navigatorKey);
    return Observer(
      builder: (context) {
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
          themeMode: themeStore.themeMode,
          title: 'Nubank Shorten Links',
        );
      },
    );
  }
}
