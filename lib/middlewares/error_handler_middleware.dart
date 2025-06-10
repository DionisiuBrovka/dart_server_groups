import 'dart:convert';

import 'package:shelf/shelf.dart';

class AppException implements Exception {
  final Map<String, dynamic> message;
  final int statusCode;

  AppException(this.message, {this.statusCode = 500});
}

// Специфические типы ошибок
class NotFoundException extends AppException {
  NotFoundException(super.message) : super(statusCode: 404);
}

class BadRequestException extends AppException {
  BadRequestException(super.message) : super(statusCode: 400);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message) : super(statusCode: 401);
}

class ForbiddenException extends AppException {
  ForbiddenException(super.message) : super(statusCode: 403);
}

// Создаем middleware
Middleware errorHandler() {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } on AppException catch (e) {
        return Response(e.statusCode, body: json.encode(e.message));
      } catch (e, stackTrace) {
        // Логируем непредвиденные ошибки
        print('Unexpected error: $e\n$stackTrace');
        return Response.internalServerError();
      }
    };
  };
}
