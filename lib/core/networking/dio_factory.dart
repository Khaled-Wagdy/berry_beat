import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: ApiConstants.apiTimeout,
          receiveTimeout: ApiConstants.apiTimeout,
          sendTimeout: ApiConstants.apiTimeout,
          headers: {ApiConstants.contentType: ApiConstants.applicationJson},
        ),
      );

      _addDioInterceptors();
    }
    return _dio!;
  }

  static void _addDioInterceptors() {
    // Authorization token interceptor
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final String? token = prefs.getString('token');
          if (token != null && token.isNotEmpty) {
            options.headers[ApiConstants.authorization] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

    // Pretty Dio Logger for debugging API calls
    if (kDebugMode) {
      _dio!.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }
}
