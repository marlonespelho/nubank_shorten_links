import 'package:flutter/material.dart';
import '../theme/palette.dart';

import '../../core/services/navigation.dart';

void showSnackBarMessage({required String message, required SnackBarTypeEnum type}) {
  final context = NavigationService().getCurrentContext();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      key: const Key('snackBarMessage'),
      duration: const Duration(seconds: 3),
      backgroundColor: {
        SnackBarTypeEnum.alert: Palette.backgroundSnackAlert,
        SnackBarTypeEnum.error: Palette.backgroundSnackError,
        SnackBarTypeEnum.success: Palette.backgroundSnackSuccess,
      }[type],
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      content: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Palette.secondary),
              maxLines: 2,
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
    ),
  );
}

enum SnackBarTypeEnum { success, alert, error }
