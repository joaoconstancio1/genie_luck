abstract class CustomHttpClient {
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
  Future<dynamic> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
  Future<dynamic> put(String url, {dynamic data, Map<String, String>? headers});
  Future<dynamic> delete(String url, {Map<String, String>? headers});
}
