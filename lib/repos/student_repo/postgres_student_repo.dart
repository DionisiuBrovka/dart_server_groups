import 'package:dart_server_groups/databases/querys.dart';
import 'package:dart_server_groups/models/student_model.dart';
import 'package:dart_server_groups/repos/student_repo/student_repo.dart';
import 'package:postgres/postgres.dart';

class PostgresStudentRepo extends StudentRepo {
  final Connection conn;

  PostgresStudentRepo({required this.conn});

  //===========================================
  @override
  Future<List<StudentModel>> getAll() async {
    final result = await conn.execute(getAllStudentsQuery());

    return result.map((element) => StudentModel.fromDataRaw(element)).toList();
  }

  //===========================================
  @override
  Future<List<StudentModel>> getByGroupId(int groupId) async {
    final result = await conn.execute(getStudentByGroupIdQuery(groupId));

    print(result);

    return result.map((element) => StudentModel.fromDataRaw(element)).toList();
  }

  //===========================================
  @override
  Future<StudentModel?> getById(int id) async {
    final result = await conn.execute(getStudentByIdQuery(id));

    if (result.length == 1) {
      return StudentModel.fromDataRaw(result[0]);
    }

    return null;
  }

  //===========================================
  @override
  Future<StudentModel?> create(StudentModel model) async {
    final result = await conn.execute(
      createStudentQuery(
        model.firstName,
        model.secondName,
        model.thirdName,
        model.group,
        model.birthday.toString(),
      ),
    );

    if (result.length == 1) {
      return StudentModel.fromDataRaw(result[0]);
    }

    return null;
  }

  //===========================================
  @override
  Future<StudentModel?> update(int id, StudentModel model) async {
    final result = await conn.execute(
      updateStudentQuery(
        id,
        model.firstName,
        model.secondName,
        model.thirdName,
        model.group,
        model.birthday.toString(),
      ),
    );

    if (result.length == 1) {
      return StudentModel.fromDataRaw(result[0]);
    }

    return null;
  }

  //===========================================
  @override
  Future<void> delete(int id) async {
    await conn.execute(deleteStudentQuery(id));
  }
}
