import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../generated/l10n.dart';
import '../../../models/main.dart';

class ShortenedLinksList extends StatelessWidget {
  const ShortenedLinksList({required this.shortenLinks, required this.onCopyLink, super.key});
  final List<ShortenLink> shortenLinks;
  final ValueChanged<String> onCopyLink;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (shortenLinks.isEmpty) {
          return Center(child: Text(S.of(context).noShortenLinksFound));
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(S.of(context).shortenedLinksHistory, style: Theme.of(context).textTheme.titleLarge),
            ...shortenLinks.map((link) => buildItemShortenLink(link, context)),
          ],
        );
      },
    );
  }

  Widget buildItemShortenLink(ShortenLink link, BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(link.shortUrl, style: Theme.of(context).textTheme.bodyMedium),
        subtitle: Text(link.originalUrl, style: Theme.of(context).textTheme.bodySmall),
        trailing: IconButton(
          onPressed: () {
            onCopyLink(link.shortUrl);
          },
          icon: Icon(Icons.copy, color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
