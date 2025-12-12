import 'package:flutter/material.dart';

class DefaultIconElevatedButton extends StatelessWidget {
  const DefaultIconElevatedButton({required this.isLoading, required this.onPressed, required this.icon, super.key});
  final bool isLoading;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary, strokeWidth: 1)
          : Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}
