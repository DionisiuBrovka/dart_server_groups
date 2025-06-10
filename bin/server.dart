import 'dart:io';

import 'package:dart_server_groups/controllers/group_controller.dart';
import 'package:dart_server_groups/controllers/student_controller.dart';
import 'package:dart_server_groups/databases/database.dart';
import 'package:dart_server_groups/middlewares/error_handler_middleware.dart';
import 'package:dart_server_groups/middlewares/json_content_type_middleware.dart';
import 'package:dart_server_groups/repos/group_repo/group_repo.dart';
import 'package:dart_server_groups/repos/group_repo/postgres_group_repo.dart';
import 'package:dart_server_groups/repos/student_repo/postgres_student_repo.dart';
import 'package:dart_server_groups/repos/student_repo/student_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  final Connection connection = await Database().conn;
  final GroupRepo groupRepo = PostgresGroupRepo(conn: connection);
  final StudentRepo studentRepo = PostgresStudentRepo(conn: connection);

  GetIt.I.registerSingleton(groupRepo);
  GetIt.I.registerSingleton(studentRepo);

  final Router router = Router();

  router.mount("/group/", GroupController().router.call);

  router.mount("/student/", StudentController().router.call);

  final handler = Pipeline()
      .addMiddleware(errorHandler())
      .addMiddleware(logRequests())
      .addMiddleware(jsonContentTypeMiddleware())
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8989');
  final server = await serve(handler, ip, port);
  print('Server listening on  http://localhost:${server.port}/');
}
