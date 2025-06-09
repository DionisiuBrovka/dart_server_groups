import 'dart:convert';

import 'package:dart_server_groups/models/group_model.dart';
import 'package:dart_server_groups/repos/group_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class GroupController {
  final Router _router = Router();
  final GroupRepo _groupRepo = GetIt.I<GroupRepo>();

  Router get router {
    _router.get("/", (Request request) async {
      final data = await _groupRepo.getAll();

      return Response.ok(json.encode(data));
    });

    _router.get("/<pk>/", (Request request, String pkArg) async {
      final int? pk = int.tryParse(pkArg);

      if (pk == null) return Response.badRequest();

      final data = await _groupRepo.get(pk);

      if (data == null) return Response.notFound("{}");

      return Response.ok(json.encode(data));
    });

    _router.post("/", (Request request) async {
      final body = await request.readAsString();

      if (body.isEmpty) return Response.badRequest();

      final bodyJson = json.decode(body);

      final GroupModelToDB bodyModel = GroupModelToDB(
        name: bodyJson['name'],
        startYear: bodyJson['startYear'],
      );

      print(bodyModel);

      final data = await _groupRepo.create(bodyModel);

      return Response.ok(json.encode(data));
    });

    _router.put("/", (Request request) async {
      return Response.ok(json.encode("{}"));
    });

    _router.delete("/", (Request request) async {
      return Response.ok(json.encode("{}"));
    });

    return _router;
  }
}
