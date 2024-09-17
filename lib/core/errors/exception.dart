class APIException implements Exception {
  APIException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;
}