import 'dart:io';

import 'package:dart_server_groups/controllers/group_controller.dart';
import 'package:dart_server_groups/databases/database.dart';
import 'package:dart_server_groups/middlewares/error_handler_middleware.dart';
import 'package:dart_server_groups/middlewares/json_content_type_middleware.dart';
import 'package:dart_server_groups/repos/group_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

Future<void> setup() async {
  final Database db = Database();

  final groupRepo = GroupRepo(db: db);
  await groupRepo.init();

  GetIt.I.registerSingleton(groupRepo);
}

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  await setup();

  final Router router = Router();

  router.mount("/group/", GroupController().router.call);

  final handler = Pipeline()
      .addMiddleware(errorHandler())
      .addMiddleware(logRequests())
      .addMiddleware(jsonContentTypeMiddleware())
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8989');
  final server = await serve(handler, ip, port);
  print('Server listening on  http://localhost:${server.port}/');
}
