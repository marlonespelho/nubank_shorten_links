import 'package:flutter/material.dart';

class RowTextLabel extends StatelessWidget {
  final String label;
  final dynamic value;

  final CrossAxisAlignment? crossAxisAlignment;

  const RowTextLabel({
    super.key,
    required this.label,
    required this.value,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 32,
      children: [
        Flexible(
          flex: 4,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                  ),
            ),
          ),
        ),
        Flexible(
          flex: 6,
          child: value is String
              ? Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              : value,
        ),
      ],
    );
  }
}
