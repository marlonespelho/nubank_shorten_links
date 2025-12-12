import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../generated/l10n.dart';
import '../../../design/stores/theme_store.dart';
import '../../../design/widgets/main.dart';
import '../../stores/shorten_link_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'widgets/shorten_link_input.dart';
import 'widgets/shortened_links_list.dart';

class ShortenLinksView extends StatefulWidget {
  const ShortenLinksView({super.key});

  @override
  State<ShortenLinksView> createState() => _ShortenLinksViewState();
}

class _ShortenLinksViewState extends State<ShortenLinksView> {
  final ShortenLinkStore shortenLinkStore = Modular.get<ShortenLinkStore>();
  final ThemeStore themeStore = Modular.get<ThemeStore>();

  final TextEditingController linkController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(title: Text(S.of(context).linkShortener), actions: [buildThemeToggle()]),
          body: GestureDetector(
            onTap: () => _dismissKeyboard(context),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [buildShortenLinksList(), buildActions()],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildThemeToggle() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: themeStore.changeThemeMode,
          icon: Icon(themeStore.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
        );
      },
    );
  }

  Widget buildShortenLinksList() {
    return Observer(
      builder: (context) {
        return Expanded(
          child: ShortenedLinksList(shortenLinks: shortenLinkStore.shortenLinks, onCopyLink: handleCopyLink),
        );
      },
    );
  }

  void handleCopyLink(String link) {
    shortenLinkStore.copyLink(link: link, successCallback: successCopyCallback, errorCallback: errorCopyCallback);
  }

  void errorCopyCallback() {
    showSnackBarMessage(message: S.of(context).errorCopyingLink, type: SnackBarTypeEnum.error);
  }

  void successCopyCallback() {
    showSnackBarMessage(message: S.of(context).linkCopiedToClipboard, type: SnackBarTypeEnum.success);
  }

  Widget buildActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).enterLinkToShorten, style: Theme.of(context).textTheme.titleMedium),
          Form(
            key: formKey,
            child: Observer(
              builder: (context) {
                return ShortenLinkInput(
                  linkController: linkController,
                  isLoading: shortenLinkStore.isLoading,
                  validateUrl: shortenLinkStore.validateUrl,
                  onFieldSubmitted: onFieldSubmitted,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void onFieldSubmitted(String value) {
    if (formKey.currentState!.validate()) {
      shortenLinkStore.shortenLink(
        url: value,
        successCallback: () {
          handleCopyLink(shortenLinkStore.shortenLinks.first.shortUrl);
        },
      );
      linkController.clear();
    }
  }

  void _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
