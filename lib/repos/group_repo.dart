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

  Future<List<GroupModel>> getAll() async {
    final result = await _conn.execute(
      'SELECT id, "name", start_year, create_at FROM public."group";',
    );
    return result.map((element) => GroupModel.fromDataRaw(element)).toList();
  }
}
