import 'dart:convert';

import 'package:dart_server_groups/middlewares/error_handler_middleware.dart';
import 'package:dart_server_groups/models/group_model.dart';
import 'package:dart_server_groups/repos/group_repo/group_repo.dart';
import 'package:excel/excel.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/shelf_multipart.dart';
import 'package:shelf_router/shelf_router.dart';

class GroupController {
  final Router _router = Router();
  final GroupRepo groupRepo;

  GroupController({required this.groupRepo});

  Router get router {
    //---------------------------------------------
    _router.get("/", (Request request) async {
      final result = (await groupRepo.getAll()).map((e) => e.toJson()).toList();
      return Response.ok(json.encode(result));
    });

    //---------------------------------------------
    _router.get("/<pk|[0-9]+>/", (Request request, String arg1) async {
      final result = await groupRepo.getById(int.parse(arg1));

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

      final result = await groupRepo.create(
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

      final result = await groupRepo.update(
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
      await groupRepo.delete(int.parse(arg1));
      return Response.ok("{}");
    });

    //---------------------------------------------
    _router.post("/import/", (Request request) async {
      final contentType = request.headers['content-type'];
      if (contentType == null || !contentType.contains('multipart/form-data')) {
        return Response.badRequest(body: 'Ожидается multipart/form-data');
      }

      if (request.formData() case var form?) {
        await for (final formData in form.formData) {
          final filename = formData.filename
              ?.split('filename="')
              .last
              .replaceAll('"', '');

          if (filename == null || !filename.endsWith('.xlsx')) {
            return Response.badRequest(body: 'Ожидается файл .xlsx');
          } else {
            var excel = Excel.decodeBytes(await formData.part.readBytes());
            print(excel.sheets);
            return Response.ok(excel.sheets.toString());
          }
        }
      }

      return Response.badRequest(body: 'Ошибка чтения файла');
    });

    return _router;
  }
}
