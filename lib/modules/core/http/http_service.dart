import 'dart:io';

import '../../../generated/l10n.dart';

abstract class HttpService {
  HttpService(this.baseUrl, this.timeout);

  String baseUrl;
  int timeout;

  void updateHeaders({Map<String, dynamic>? headers});

  Future<dynamic> get<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    void Function(Object)? onError,
  });

  Future<dynamic> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    void Function(Object)? onError,
  });

  Future<dynamic> put<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    void Function(Object)? onError,
    Map<String, dynamic>? headers,
  });

  Future<dynamic> delete<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    void Function(Object)? onError,
  });

  Future<dynamic> patch<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    void Function(Object)? onError,
  });
}

abstract class HttpError extends HttpException {
  HttpError({this.statusCode, dynamic serverError, String? message})
    : super(message ?? S.current.defaultExceptionMessage) {
    _serverError = serverError;
  }
  late int? statusCode;
  late final dynamic _serverError;

  @override
  String toString() {
    if (_serverError != null) {
      return _serverError.toString();
    }
    return message;
  }

  dynamic get serverError => _serverError;
}

class BadRequestException extends HttpError {
  BadRequestException({super.statusCode = 400, String? message, super.serverError})
    : super(message: message ?? S.current.badRequestExceptionMessage);

  @override
  String toString() {
    return message;
  }
}

class NotFoundException extends HttpError {
  NotFoundException({super.statusCode = 404, String? message, super.serverError})
    : super(message: message ?? S.current.notFoundExceptionMessage);

  @override
  String toString() {
    return message;
  }
}

class NoConnectionException extends HttpError {
  NoConnectionException({super.statusCode = 500, String? message, super.serverError})
    : super(message: message ?? S.current.noConnectionExceptionMessage);

  @override
  String toString() {
    return message;
  }
}

class TimeOutException extends HttpError {
  TimeOutException({super.statusCode = 500, String? message, super.serverError})
    : super(message: message ?? S.current.timeOutExceptionMessage);

  @override
  String toString() {
    return message;
  }
}

class UnauthorizedException extends HttpError {
  UnauthorizedException({super.statusCode = 401, String? message, super.serverError})
    : super(message: message ?? S.current.unauthorizedExceptionMessage);

  @override
  String toString() {
    return message;
  }
}

class UnprocessableEntityException extends HttpError {
  UnprocessableEntityException({super.statusCode = 422, String? message, super.serverError})
    : super(message: message ?? S.current.badRequestExceptionMessage);

  @override
  String toString() {
    return message;
  }
}

class InternalServerError extends HttpError {
  InternalServerError({super.statusCode = 500, String? message, super.serverError})
    : super(message: message ?? S.current.defaultExceptionMessage);

  @override
  String toString() {
    return message;
  }
}

class UnexpectedException extends HttpError {
  UnexpectedException({super.statusCode = 500, String? message, super.serverError})
    : super(message: message ?? S.current.defaultExceptionMessage);

  @override
  String toString() {
    return message;
  }
}

class HttpExceptionError extends HttpError {
  HttpExceptionError({super.statusCode = 500, String? message, super.serverError})
    : super(message: message ?? S.current.defaultExceptionMessage);
}
