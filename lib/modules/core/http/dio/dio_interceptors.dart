// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import '../http_service.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestData = jsonEncode(options.data);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final responseData = jsonEncode(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final requestData = jsonEncode(err.requestOptions.data);
    Exception? exception;
    final int? statusCode = err.response?.statusCode;
    final dynamic responseData = err.response?.data;
    final dynamic errorMessage = (responseData is Map<String, dynamic>)
        ? (responseData['error'] ?? responseData['errors'])
        : null;
    if (statusCode != null) {
      exception = {
        400: BadRequestException(statusCode: err.response?.statusCode, serverError: errorMessage),
        401: UnauthorizedException(statusCode: err.response?.statusCode, serverError: errorMessage),
        404: NotFoundException(statusCode: err.response?.statusCode, serverError: errorMessage),
        422: UnprocessableEntityException(statusCode: err.response?.statusCode, serverError: errorMessage),
        500: (err.message != null && err.message!.toString().contains('401'))
            ? UnauthorizedException(statusCode: err.response?.statusCode, serverError: errorMessage)
            : InternalServerError(statusCode: err.response?.statusCode, serverError: errorMessage),
        522: TimeOutException(statusCode: err.response?.statusCode, serverError: errorMessage),
      }[statusCode];
    }

    exception ??= {
      DioExceptionType.connectionError: NoConnectionException(
        statusCode: err.response?.statusCode,
        serverError: errorMessage,
      ),
      DioExceptionType.connectionTimeout: TimeOutException(
        statusCode: err.response?.statusCode,
        serverError: errorMessage,
      ),
      DioExceptionType.receiveTimeout: TimeOutException(
        statusCode: err.response?.statusCode,
        serverError: errorMessage,
      ),
      DioExceptionType.sendTimeout: TimeOutException(statusCode: err.response?.statusCode, serverError: errorMessage),
      DioExceptionType.unknown: UnexpectedException(statusCode: err.response?.statusCode, serverError: errorMessage),
    }[err.type];

    if (err.error is SocketException) {
      exception = NoConnectionException();
    }

    final dynamic responseDataError = err.response?.data;
    dynamic serverError;
    if (responseDataError is Map<String, dynamic> && responseDataError['errors'] is Map<String, dynamic>) {
      final errorsMap = responseDataError['errors'] as Map<String, dynamic>;
      serverError = errorsMap['json'];
    }
    exception ??= UnexpectedException(statusCode: err.response?.statusCode, serverError: serverError);

    throw exception;
  }
}
