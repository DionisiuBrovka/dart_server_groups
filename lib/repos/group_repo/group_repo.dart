import 'package:dart_server_groups/models/group_model.dart';

abstract class GroupRepo {
  Future<List<GroupModel>> getAll();
  Future<GroupModel?> getById(int id);
  Future<GroupModel?> create(GroupModel model);
  Future<GroupModel?> update(int id, GroupModel model);
  Future<void> delete(int id);
}
