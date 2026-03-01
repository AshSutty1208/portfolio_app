import 'package:portfolio_app/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Endpoint {
  static const String pokemon = "/pokemon/";
  static const String pokemonCharacteristic = "/characteristic/";
}

mixin class BaseService {
  Dio? _dio;

  String _getBaseUrl() {
    return 'https://pokeapi.co/api/v2/';
  }

  Dio getDio() {
    if (_dio == null) {
      final dio = Dio();
      dio.options.baseUrl = _getBaseUrl();
      dio.options.connectTimeout = const Duration(seconds: 30);
      dio.options.receiveTimeout = const Duration(seconds: 30);
      dio.options.sendTimeout = const Duration(seconds: 30);

      if (kDebugMode) {
        dio.interceptors.add(
          LogInterceptor(
            requestBody: true,
            responseBody: true,
            logPrint: (content) async {
              // ignore: avoid_print
              logStringInChunks('DIO', content.toString());
            },
          ),
        );
      }

      _dio = dio;
    }

    return _dio!;
  }
}

abstract class ApiResult<T> {
  static Future<ApiResult<T>> fromResponse<T>(
    Response response,
    Future<T> Function(dynamic responseMap)? customMapper,
  ) async {
    switch (response.statusCode) {
      case 200:
        return await handleResponse(response.data, customMapper);
      case 201:
        return await handleResponse(response.data, customMapper);
      case 204:
        return await handleResponse(response.data, customMapper);
      case 400:
        return handleError(response);
      case 401:
        return handleError(response);
      case 403:
        return handleError(response);
      case 500:
        return handleError(response);
      default:
        return handleError(response);
    }
  }

  static Future<ApiResult<T>> handleResponse<T>(
    dynamic responseData,
    Future<T> Function(dynamic responseMap)? customMapper,
  ) async {
    if (customMapper == null) {
      return Success(responseData);
    }

    return Success(await customMapper(responseData));
  }

  static ApiResult<T> handleError<T>(Response response) {
    return Failed(response.extra['error'] ?? 'Unknown error');
  }
}

class Success<T> extends ApiResult<T> {
  final T data;

  Success(this.data);
}

class Failed<T> extends ApiResult<T> {
  final String message;

  Failed(this.message);
}

List<T> responseDataListMapper<T>(
  List<dynamic> data,
  T Function(Map<String, dynamic>) objectMapper,
) {
  if (data.isEmpty) {
    return [];
  }

  final List<T> list = [];
  for (final json in data) {
    final mappedObject = objectMapper(json);
    list.add(mappedObject);
  }
  return list;
}
