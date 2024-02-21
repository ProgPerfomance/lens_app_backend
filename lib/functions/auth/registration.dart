import 'package:mysql_client/mysql_client.dart';

Future<void> createUser({
  required var email,
  required var name,
  required var password,
  required var description,
  required var freelancer,
  required var experience,
  required var balance,
}) async {
  var sql = await MySQLConnection.createConnection(
      host: 'localhost',
      port: 3306,
      userName: 'root',
      password: '1234567890',
      databaseName: 'lensapp');
  await sql.connect();
  print(sql.connected);
  var resul = await sql.execute(
    "SELECT * FROM users",
    {},
  );
  String id = resul.rows.last.assoc()['id']!;
  int id_int = int.parse(id);
  print(id_int);
  var result = sql.execute(
      "insert into users (id,name,email,description,freelancer,experience,balance,password_hast) values (${id_int + 1}, '$name', '$email', '$description', $freelancer, $experience, $balance, '$password')");
  await sql.close();
}
