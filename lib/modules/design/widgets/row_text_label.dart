import 'package:flutter/material.dart';

class RowTextLabel extends StatelessWidget {
  const RowTextLabel({required this.label, required this.value, super.key, this.crossAxisAlignment});
  final String label;
  final dynamic value;

  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      spacing: 32,
      children: [
        Flexible(
          flex: 4,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)),
          ),
        ),
        Flexible(
          flex: 6,
          child: value is String
              ? Text(value as String, style: Theme.of(context).textTheme.bodyMedium)
              : value as Widget,
        ),
      ],
    );
  }
}
