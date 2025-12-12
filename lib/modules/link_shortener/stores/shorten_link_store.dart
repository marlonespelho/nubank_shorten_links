import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import '../models/main.dart';
import '../use_cases/get_shorten_link_use_case.dart';

part 'shorten_link_store.g.dart';

class ShortenLinkStore = ShortenLinkStoreBase with _$ShortenLinkStore;

abstract class ShortenLinkStoreBase with Store {
  ShortenLinkStoreBase({required this.getShortenLinkUseCase});
  final GetShortenLinkUseCaseContract getShortenLinkUseCase;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<ShortenLink> shortenLinks = ObservableList<ShortenLink>();

  @action
  Future<void> shortenLink({required String url, required VoidCallback successCallback}) async {
    try {
      isLoading = true;
      final result = await getShortenLinkUseCase.execute(url);
      shortenLinks.insert(0, result);
      successCallback();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> copyLink({
    required String link,
    required VoidCallback successCallback,
    required VoidCallback errorCallback,
  }) async {
    try {
      await Clipboard.setData(ClipboardData(text: link));
      successCallback();
    } catch (e) {
      errorCallback();
    }
  }

  bool validateUrl(String? value) {
    final regex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*(\?[\w\d \.-=&]*)?(\#[\w\d \.-=&]*)?$',
    );
    return regex.hasMatch(value ?? '');
  }
}
