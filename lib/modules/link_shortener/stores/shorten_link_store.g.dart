// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shorten_link_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShortenLinkStore on ShortenLinkStoreBase, Store {
  late final _$isLoadingAtom = Atom(name: '_ShortenLinkStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$shortenLinksAtom = Atom(name: '_ShortenLinkStore.shortenLinks', context: context);

  @override
  ObservableList<ShortenLink> get shortenLinks {
    _$shortenLinksAtom.reportRead();
    return super.shortenLinks;
  }

  @override
  set shortenLinks(ObservableList<ShortenLink> value) {
    _$shortenLinksAtom.reportWrite(value, super.shortenLinks, () {
      super.shortenLinks = value;
    });
  }

  late final _$shortenLinkAsyncAction = AsyncAction('_ShortenLinkStore.shortenLink', context: context);

  @override
  Future<void> shortenLink({required String url, required dynamic Function() successCallback}) {
    return _$shortenLinkAsyncAction.run(() => super.shortenLink(url: url, successCallback: successCallback));
  }

  late final _$copyLinkAsyncAction = AsyncAction('_ShortenLinkStore.copyLink', context: context);

  @override
  Future<void> copyLink({
    required String link,
    required dynamic Function() successCallback,
    required dynamic Function() errorCallback,
  }) {
    return _$copyLinkAsyncAction.run(
      () => super.copyLink(link: link, successCallback: successCallback, errorCallback: errorCallback),
    );
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
shortenLinks: ${shortenLinks}
    ''';
  }
}
