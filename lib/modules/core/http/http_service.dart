import 'dart:io';

import 'package:nubank_shorten_links/generated/l10n.dart';

abstract class HttpService {
  HttpService(this.baseUrl, this.timeout);

  String baseUrl;
  int timeout;

  updateHeaders({headers});

  Future get({required String path, data, queryParams, Function? onError});

  Future post({required String path, data, queryParams, Function? onError});

  Future put({required String path, data, queryParams, Function? onError, Map<String, dynamic>? headers});

  Future delete({required String path, data, queryParams, Function? onError});

  Future patch({required String path, data, queryParams, Function? onError});
}

abstract class HttpError extends HttpException {
  late int? statusCode;
  late final dynamic _serverError;

  HttpError({this.statusCode, serverError, message}) : super(message ?? S.current.defaultExceptionMessage) {
    _serverError = serverError;
  }

  @override
  String toString() {
    return _serverError ?? message;
  }

  get serverError => _serverError;
}

class BadRequestException extends HttpError {
  BadRequestException({super.statusCode = 400, String? message, super.serverError}) {
    message = message ?? S.current.badRequestExceptionMessage;
  }

  @override
  toString() {
    return message;
  }
}

class NotFoundException extends HttpError {
  NotFoundException({super.statusCode = 404, String? message, super.serverError}) {
    message = message ?? S.current.notFoundExceptionMessage;
  }

  @override
  toString() {
    return message;
  }
}

class NoConnectionException extends HttpError {
  NoConnectionException({super.statusCode = 500, String? message, super.serverError}) {
    message = message ?? S.current.noConnectionExceptionMessage;
  }

  @override
  toString() {
    return message;
  }
}

class TimeOutException extends HttpError {
  TimeOutException({super.statusCode = 500, String? message, super.serverError}) {
    message = message ?? S.current.timeOutExceptionMessage;
  }

  @override
  toString() {
    return message;
  }
}

class UnauthorizedException extends HttpError {
  UnauthorizedException({super.statusCode = 401, String? message, super.serverError}) {
    message = message ?? S.current.unauthorizedExceptionMessage;
  }

  @override
  toString() {
    return message;
  }
}

class UnprocessableEntityException extends HttpError {
  UnprocessableEntityException({super.statusCode = 422, String? message, super.serverError}) {
    message = message ?? S.current.badRequestExceptionMessage;
  }

  @override
  toString() {
    return message;
  }
}

class InternalServerError extends HttpError {
  InternalServerError({super.statusCode = 500, String? message, super.serverError}) {
    message = message ?? S.current.defaultExceptionMessage;
  }

  @override
  toString() {
    return message;
  }
}

class UnexpectedException extends HttpError {
  UnexpectedException({super.statusCode = 500, String? message, super.serverError}) {
    message = message ?? S.current.defaultExceptionMessage;
  }

  @override
  toString() {
    return message;
  }
}

class HttpExceptionError extends HttpError {
  HttpExceptionError({super.statusCode = 500, String? message, super.serverError}) {
    message = message ?? S.current.defaultExceptionMessage;
  }
}
