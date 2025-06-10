import 'package:dart_server_groups/models/student_model.dart';

abstract class StudentRepo {
  Future<List<StudentModel>> getAll();
  Future<StudentModel?> getById(int id);
  Future<List<StudentModel>> getByGroupId(int groupId);
  Future<StudentModel?> create(StudentModel model);
  Future<StudentModel?> update(int id, StudentModel model);
  Future<void> delete(int id);
}
