import 'package:dart_server_groups/databases/database.dart';
import 'package:dart_server_groups/databases/querys.dart';
import 'package:dart_server_groups/models/group_model.dart';
import 'package:dart_server_groups/repos/group_repo/group_repo.dart';
import 'package:dart_server_groups/repos/repo_errors.dart';
import 'package:postgres/postgres.dart';

class PostgresGroupRepo extends GroupRepo {
  final Database db;
  late final Connection _conn;

  PostgresGroupRepo({required this.db});

  Future<void> init() async {
    _conn = await db.conn;
  }

  Future<void> dispose() async {}

  //===========================================
  @override
  Future<List<GroupModel>> getAll() async {
    final result = await _conn.execute(getAllGroupsQuery());

    return result.map((element) => GroupModel.fromDataRaw(element)).toList();
  }

  //===========================================
  @override
  Future<GroupModel?> getById(int id) async {
    final result = await _conn.execute(getGroupByIdQuery(id));

    if (result.length == 1) {
      return GroupModel.fromDataRaw(result[0]);
    }

    return null;
  }

  //===========================================
  @override
  Future<GroupModel?> create(GroupModel model) async {
    final result = await _conn.execute(
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
    final result = await _conn.execute(
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
    try {
      await _conn.execute(deleteGroupQuery(id));
    } catch (e) {
      throw RepoErrors();
    }
  }
}
