import 'package:postgres/postgres.dart';

class Database {
  Future<Connection> get conn async => await Connection.open(
    Endpoint(
      host: 'localhost',
      database: 'server_group',
      username: 'group_db_admin',
      password: 'mgkct',
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );
}
