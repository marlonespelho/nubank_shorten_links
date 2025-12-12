import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nubank_shorten_links/modules/core/app/app_module.dart';
import 'package:nubank_shorten_links/modules/core/app/app_widget.dart';

class AppCore extends StatelessWidget {
  const AppCore({super.key});

  @override
  Widget build(BuildContext context) {
    return ModularApp(module: AppModule(), child: const AppWidget());
  }
}
