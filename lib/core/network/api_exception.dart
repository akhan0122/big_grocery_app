import 'package:dio/dio.dart';

class ApiException implements Exception {
  const ApiException({required this.message, this.statusCode, this.data});

  final String message;
  final int? statusCode;
  final Object? data;

  factory ApiException.fromDioException(DioException error) {
    return ApiException(
      message: _messageFromError(error),
      statusCode: error.response?.statusCode,
      data: error.response?.data,
    );
  }

  static String _messageFromError(DioException error) {
    final responseMessage = _messageFromResponse(error.response?.data);
    if (responseMessage != null) return responseMessage;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Request timed out. Please try again.';
      case DioExceptionType.badCertificate:
        return 'Secure connection failed.';
      case DioExceptionType.badResponse:
        return 'Server error. Please try again.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.unknown:
        return error.message ?? 'Something went wrong.';
    }
  }

  static String? _messageFromResponse(Object? data) {
    if (data is Map) {
      final message = data['message'] ?? data['error'];
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }
      if (message is List && message.isNotEmpty) {
        return message.join(', ');
      }
    }
    return null;
  }

  @override
  String toString() => message;
}
