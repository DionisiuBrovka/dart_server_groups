import 'package:dart_server_groups/databases/database.dart';
import 'package:dart_server_groups/models/group_model.dart';
import 'package:postgres/postgres.dart';

class GroupRepo {
  final Database db;
  late final Connection _conn;

  GroupRepo({required this.db});

  Future<void> init() async {
    _conn = await db.conn;
  }

  Future<void> dispose() async {}

  Future<List<GroupModel>> getAll() async {
    final result = await _conn.execute('SELECT * FROM public."group";');
    return result.map((element) => GroupModel.fromDataRaw(element)).toList();
  }

  Future<GroupModel?> get(int id) async {
    final result = await _conn.execute(
      'SELECT * FROM public."group" where id = $id;',
    );

    if (result.length == 1) {
      return GroupModel.fromDataRaw(result[0]);
    }

    return null;
  }

  Future<GroupModel?> create(GroupModelToDB model) async {
    final result = await _conn.execute(
      "INSERT INTO public.group (name, start_year) VALUES('${model.name}', ${model.startYear}) RETURNING *;",
    );

    if (result.length == 1) {
      return GroupModel.fromDataRaw(result[0]);
    }

    return null;
  }

  Future<GroupModel?> update() async {
    return null;
  }

  Future<void> delete() async {}
}
