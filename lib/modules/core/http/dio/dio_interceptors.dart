// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nubank_shorten_links/modules/core/http/http_service.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var requestData = jsonEncode(options.data);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    var responseData = jsonEncode(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var requestData = jsonEncode(err.requestOptions.data);
    Exception? exception;
    int? statusCode = err.response?.statusCode;
    var errorMessage = err.response?.data?["error"] ?? err.response?.data?['errors'];
    if (statusCode != null) {
      exception = {
        400: BadRequestException(statusCode: err.response?.statusCode, serverError: errorMessage),
        401: UnauthorizedException(statusCode: err.response?.statusCode, serverError: errorMessage),
        404: NotFoundException(statusCode: err.response?.statusCode, serverError: errorMessage),
        422: UnprocessableEntityException(statusCode: err.response?.statusCode, serverError: errorMessage),
        500: (err.message != null && err.message!.toString().contains("401"))
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

    exception ??= UnexpectedException(
      statusCode: err.response?.statusCode,
      serverError: err.response?.data['errors']['json'],
    );

    throw exception;
  }
}
