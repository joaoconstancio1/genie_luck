import 'package:dio/dio.dart';
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
    final response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final response = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> put(
    String url, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    final response = await _dio.put(
      url,
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    final response = await _dio.delete(url, options: Options(headers: headers));
    return response.data;
  }
}
