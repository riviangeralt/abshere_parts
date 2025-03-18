import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:app/utils/env_config.dart';

class ApiClient {
  late Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '${FlavorConfig.config.baseUrl}/hr-insights/v1',
        connectTimeout: const Duration(seconds: 5000),
        receiveTimeout: const Duration(seconds: 5000),
        headers: {
          'Accept': 'application/json',
          'x-apikey': FlavorConfig.config.apiKey,
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      log('Error: $e');
      rethrow;
    }
  }

  Future<dynamic> post(
    String endpoint, {
    Object? data,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      log('Error: $e');
      rethrow;
    }
  }

  void close() {
    _dio.close();
  }
}
