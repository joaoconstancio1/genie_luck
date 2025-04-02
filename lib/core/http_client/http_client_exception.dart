class HttpClientException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic errorData;

  HttpClientException({required this.message, this.statusCode, this.errorData});

  @override
  String toString() => 'HttpClientException: $message (Status: $statusCode)';
}
