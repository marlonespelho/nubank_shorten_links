import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  static showLoading(BuildContext context) {
    showDialog(context: context, barrierDismissible: false, builder: (context) => const LoadingDialog());
  }

  static hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
