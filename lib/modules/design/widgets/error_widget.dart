import 'package:dio/dio.dart';
import '../../core/http/http_service.dart';
import 'main.dart';

Future<void> handleException(Object e, [void Function(Object)? onError, StackTrace? stack]) async {
  if (onError != null) {
    onError(e);
    return;
  }

  if (e is DioException && e.error is HttpError) {
    final HttpError error = e.error as HttpError;
    showSnackBarMessage(message: error.message, type: SnackBarTypeEnum.error);
    return;
  }

  showSnackBarMessage(message: e.toString(), type: SnackBarTypeEnum.error);
  return;
}
