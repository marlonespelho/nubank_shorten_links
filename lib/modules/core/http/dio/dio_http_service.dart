import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'dio_interceptors.dart';
import '../http_service.dart';
import '../../../design/widgets/error_widget.dart';

class DioHttpService implements HttpService {
  DioHttpService({required this.baseUrl, this.timeout = 10, InterceptorsWrapper? interceptor}) {
    _client = Dio();
    _client.interceptors.add(interceptor ?? DioInterceptor());
    _client.options.baseUrl = baseUrl;
    _client.options.connectTimeout = Duration(seconds: timeout);
    _client.options.receiveTimeout = Duration(seconds: timeout);

    if (kIsWeb) {
      return;
    }

    (_client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
  late Dio _client;

  @override
  String baseUrl;

  @override
  int timeout;

  @override
  Future<dynamic> delete<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    void Function(Object)? onError,
  }) async {
    try {
      final response = await _client.delete<T>(path, data: data, queryParameters: queryParams);
      return response.data;
    } catch (e, stack) {
      await handleException(e, onError, stack);
      rethrow;
    }
  }

  @override
  Future<dynamic> get<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    void Function(Object)? onError,
  }) async {
    try {
      final response = await _client.get<T>(path, data: data, queryParameters: queryParams);
      return response.data;
    } catch (e, stack) {
      await handleException(e, onError, stack);
      rethrow;
    }
  }

  @override
  Future<dynamic> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    void Function(Object)? onError,
  }) async {
    try {
      final response = await _client.post<T>(path, data: data, queryParameters: queryParams);
      return response.data;
    } catch (e, stack) {
      await handleException(e, onError, stack);
      rethrow;
    }
  }

  @override
  Future<dynamic> put<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    void Function(Object)? onError,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _client.put<T>(
        path,
        data: data,
        queryParameters: queryParams,
        options: headers != null ? Options(headers: headers) : null,
      );
      return response.data;
    } catch (e, stack) {
      await handleException(e, onError, stack);
      rethrow;
    }
  }

  @override
  Future<dynamic> patch<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    void Function(Object)? onError,
  }) async {
    try {
      final response = await _client.patch<T>(path, data: data, queryParameters: queryParams);
      return response.data;
    } catch (e, stack) {
      await handleException(e, onError, stack);
      rethrow;
    }
  }

  @override
  void updateHeaders({Map<String, dynamic>? headers}) {
    _client.options.headers = headers;
  }
}
