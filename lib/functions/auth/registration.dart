import 'package:mysql_client/mysql_client.dart';

Future<int> createUser({
  required MySQLConnection sql,
  required var email,
  required var name,
  required var password,
  required var description,
  required var freelancer,
  required var experience,
  required var balance,
}) async {
  var resul = await sql.execute(
    "SELECT * FROM users",
    {},
  );
  String id = resul.rows.last.assoc()['id']!;
  int id_int = int.parse(id);
  print(id_int);
  sql.execute(
      "insert into users (id,name,email,description,freelancer,experience,balance,password_hast) values (${id_int + 1}, '$name', '$email', '$description', $freelancer, $experience, $balance, '$password')");
  return (id_int+1);
}
