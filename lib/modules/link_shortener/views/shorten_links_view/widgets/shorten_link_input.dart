import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../../../design/widgets/main.dart';

class ShortenLinkInput extends StatelessWidget {
  const ShortenLinkInput({
    required this.linkController,
    required this.isLoading,
    required this.validateUrl,
    required this.onFieldSubmitted,
    super.key,
  });
  final TextEditingController linkController;
  final bool isLoading;
  final bool Function(String) validateUrl;
  final ValueChanged<String> onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DefaultTextFormField(
            key: const Key('shortenLinkTextField'),
            controller: linkController,
            decoration: InputDecoration(labelText: S.of(context).link),
            enabled: !isLoading,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: onFieldSubmitted,
            validator: (value) {
              final isValid = validateUrl(value ?? '');
              return isValid ? null : S.of(context).linkIsInvalid;
            },
          ),
        ),
        DefaultIconElevatedButton(
          key: const Key('shortenLinkButton'),
          isLoading: isLoading,
          icon: Icons.send,
          onPressed: () {
            onFieldSubmitted(linkController.text);
          },
        ),
      ],
    );
  }
}
