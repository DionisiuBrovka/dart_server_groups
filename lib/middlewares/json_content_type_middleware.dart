import 'package:shelf/shelf.dart';

// Создаем middleware
Middleware jsonContentTypeMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      // Вызываем внутренний обработчик
      final response = await innerHandler(request);

      // Добавляем заголовок Content-Type
      return response.change(
        headers: {...response.headers, 'Content-Type': 'application/json'},
      );
    };
  };
}
