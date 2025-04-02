import 'package:dio/dio.dart';
import 'package:genie_luck/core/http_client/http_client_exception.dart';
import 'custom_http_client.dart';

class DioHttpClient implements CustomHttpClient {
  final Dio _dio;

  DioHttpClient(this._dio);

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<dynamic> put(
    String url, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.delete(
        url,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  Never _handleError(dynamic error) {
    if (error is DioException && error.response != null) {
      final response = error.response!;
      final statusCode = response.statusCode;
      final errorData = response.data;
      final message =
          errorData is Map<String, dynamic> && errorData['error'] != null
              ? errorData['error']
              : 'Request error';
      throw HttpClientException(
        message: message,
        statusCode: statusCode,
        errorData: errorData,
      );
    } else {
      throw HttpClientException(message: 'Unexpected error: $error');
    }
  }
}
