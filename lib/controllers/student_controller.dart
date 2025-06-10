import 'dart:convert';

import 'package:dart_server_groups/middlewares/error_handler_middleware.dart';
import 'package:dart_server_groups/models/student_model.dart';
import 'package:dart_server_groups/repos/student_repo/student_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class StudentController {
  final Router _router = Router();
  final StudentRepo studentRepo = GetIt.I();

  Router get router {
    //---------------------------------------------
    _router.get("/", (Request request) async {
      final result = (await studentRepo.getAll())
          .map((e) => e.toJson())
          .toList();
      return Response.ok(json.encode(result));
    });

    //---------------------------------------------
    _router.get("/<pk|[0-9]+>/", (Request request, String arg1) async {
      final result = await studentRepo.getById(int.parse(arg1));

      if (result == null) {
        throw NotFoundException({"error": "Группа не найдена"});
      }

      return Response.ok(json.encode(result));
    });

    //---------------------------------------------
    _router.get("/group/<pk|[0-9]+>/", (Request request, String arg1) async {
      final result = await studentRepo.getByGroupId(int.parse(arg1));

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

      print(requestData);

      if (requestData.containsKey("firstName")) {
        print("ok");
      } else {
        print("not ok");
      }

      final String firstName = requestData["firstName"];
      final String secondName = requestData["secondName"];
      final String thirdName = requestData["thirdName"];
      final int? groupId = requestData["group"];
      final DateTime birthday = DateTime.parse(requestData["birthday"]);

      final result = await studentRepo.create(
        StudentModel(
          firstName: firstName,
          secondName: secondName,
          thirdName: thirdName,
          group: groupId,
          birthday: birthday,
        ),
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

      final String firstName = requestData["name"];
      final String secondName = requestData["name"];
      final String thirdName = requestData["name"];
      final int groupId = requestData["name"];
      final DateTime birthday = requestData["name"];

      final result = await studentRepo.update(
        int.parse(arg1),
        StudentModel(
          firstName: firstName,
          secondName: secondName,
          thirdName: thirdName,
          group: groupId,
          birthday: birthday,
        ),
      );

      if (result == null) {
        throw NotFoundException({"error": "Группа не найдена"});
      }

      return Response.ok(json.encode(result));
    });

    //---------------------------------------------
    _router.delete("/<pk|[0-9]+>/", (Request request, String arg1) async {
      await studentRepo.delete(int.parse(arg1));
      return Response.ok("{}");
    });

    return _router;
  }
}
