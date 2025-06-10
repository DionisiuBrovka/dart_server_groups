import 'package:postgres/postgres.dart';

class Database {
  Future<Connection> get conn async => await Connection.open(
    Endpoint(
      host: 'localhost',
      database: 'server_group',
      username: 'server_group_admin',
      password: 'mata2042',
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );
}
