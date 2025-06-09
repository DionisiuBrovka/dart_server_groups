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
      try {
        final result = (await _groupRepo.getAll())
            .map((e) => e.toJson())
            .toList();
        return Response.ok(json.encode(result));
      } catch (e) {
        return Response.internalServerError(body: "{'error':$e}");
      }
    });

    _router.get("/<pk|[0-9]+>/", (Request request, String arg1) async {
      try {
        final result = await _groupRepo.getById(int.parse(arg1));
        return Response.ok(json.encode(result));
      } catch (e) {
        return Response.internalServerError(body: "{'error':$e}");
      }
    });

    _router.post("/", (Request request) async {
      try {
        final requestData = json.decode(await request.readAsString());
        final result = await _groupRepo.create(
          GroupModelToDB(
            name: requestData["name"],
            startYear: requestData["startYear"],
          ),
        );
        return Response.ok(json.encode(result));
      } catch (e) {
        return Response.internalServerError(body: "{'error':$e}");
      }
    });

    _router.put("/<pk|[0-9]+>/", (Request request, String arg1) async {
      try {
        final requestData = json.decode(await request.readAsString());
        final result = await _groupRepo.update(
          int.parse(arg1),
          GroupModelToDB(
            name: requestData["name"],
            startYear: requestData["startYear"],
          ),
        );
        return Response.ok(json.encode(result));
      } catch (e) {
        return Response.internalServerError(body: "{'error':$e}");
      }
    });

    _router.delete("/<pk|[0-9]+>/", (Request request, String arg1) async {
      try {
        await _groupRepo.delete(int.parse(arg1));
        return Response.ok("{}");
      } catch (e) {
        return Response.internalServerError(body: "{'error':$e}");
      }
    });

    return _router;
  }
}
