import 'package:dart_server_groups/databases/querys.dart';
import 'package:dart_server_groups/models/group_model.dart';
import 'package:dart_server_groups/repos/group_repo/group_repo.dart';
import 'package:postgres/postgres.dart';

class PostgresGroupRepo extends GroupRepo {
  final Connection conn;

  PostgresGroupRepo({required this.conn});

  //===========================================
  @override
  Future<List<GroupModel>> getAll() async {
    final result = await conn.execute(getAllGroupsQuery());

    return result.map((element) => GroupModel.fromDataRaw(element)).toList();
  }

  //===========================================
  @override
  Future<GroupModel?> getById(int id) async {
    final result = await conn.execute(getGroupByIdQuery(id));

    if (result.length == 1) {
      return GroupModel.fromDataRaw(result[0]);
    }

    return null;
  }

  //===========================================
  @override
  Future<GroupModel?> create(GroupModel model) async {
    final result = await conn.execute(
      createGroupQuery(model.name, model.startYear),
    );

    if (result.length == 1) {
      return GroupModel.fromDataRaw(result[0]);
    }

    return null;
  }

  //===========================================
  @override
  Future<GroupModel?> update(int id, GroupModel model) async {
    final result = await conn.execute(
      updateGroupQuery(id, model.name, model.startYear),
    );

    if (result.length == 1) {
      return GroupModel.fromDataRaw(result[0]);
    }
    return null;
  }

  //===========================================
  @override
  Future<void> delete(int id) async {
    await conn.execute(deleteGroupQuery(id));
  }
}
