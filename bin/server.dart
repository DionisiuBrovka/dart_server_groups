import 'dart:convert';
import 'dart:io';

import 'package:dart_server_groups/databases/database.dart';
import 'package:dart_server_groups/repos/group_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler);

Future<Response> _rootHandler(Request req) async {
  final repo = GetIt.I<GroupRepo>();
  final res = await repo.getAll();
  return Response.ok(
    json.encode(res.map((e) => e.toJson()).toList()),
    headers: {"Content-Type": "application/json"},
  );
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Future<void> setup() async {
  final Database db = Database();

  final groupRepo = GroupRepo(db: db);
  await groupRepo.init();

  GetIt.I.registerSingleton(groupRepo);
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).

  await setup();

  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8889');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
