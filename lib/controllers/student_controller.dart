import 'dart:convert';

import 'package:dart_server_groups/middlewares/error_handler_middleware.dart';
import 'package:dart_server_groups/models/group_model.dart';
import 'package:dart_server_groups/repos/group_repo/group_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class StudentController {
  final Router _router = Router();
  final GroupRepo _groupRepo = GetIt.I<GroupRepo>();

  Router get router {
    //---------------------------------------------
    _router.get("/", (Request request) async {
      final result = (await _groupRepo.getAll())
          .map((e) => e.toJson())
          .toList();
      return Response.ok(json.encode(result));
    });

    //---------------------------------------------
    _router.get("/<pk|[0-9]+>/", (Request request, String arg1) async {
      final result = await _groupRepo.getById(int.parse(arg1));

      if (result == null) {
        throw NotFoundException({"error": "Группа не найдена"});
      }

      return Response.ok(json.encode(result));
    });

    //---------------------------------------------
    _router.post("/", (Request request) async {
      late final Map<String, dynamic> requestData;

      try {
        requestData = json.decode(await request.readAsString());
      } catch (e) {
        throw BadRequestException({"error": "Данные запроса не валидны"});
      }

      final String name = requestData["name"];
      final int startYear = requestData["startYear"];

      final result = await _groupRepo.create(
        GroupModel(name: name, startYear: startYear),
      );

      return Response.ok(json.encode(result));
    });

    //---------------------------------------------
    _router.put("/<pk|[0-9]+>/", (Request request, String arg1) async {
      late final Map<String, dynamic> requestData;

      try {
        requestData = json.decode(await request.readAsString());
      } catch (e) {
        throw BadRequestException({"error": "Данные запроса не валидны"});
      }

      final String name = requestData["name"];
      final int startYear = requestData["startYear"];

      final result = await _groupRepo.update(
        int.parse(arg1),
        GroupModel(name: name, startYear: startYear),
      );

      if (result == null) {
        throw NotFoundException({"error": "Группа не найдена"});
      }

      return Response.ok(json.encode(result));
    });

    //---------------------------------------------
    _router.delete("/<pk|[0-9]+>/", (Request request, String arg1) async {
      await _groupRepo.delete(int.parse(arg1));
      return Response.ok("{}");
    });

    return _router;
  }
}
