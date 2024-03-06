import 'package:mysql_client/mysql_client.dart';

Future<List> getPhotographs({
  required uid,
  required MySQLConnection sql,
}) async {
  List users = [];
  final response = await sql.execute(
    "SELECT * FROM users where freelancer = 1",
    {},
  );

  for (final row in response.rows) {
    var data = row.assoc();
    print(data);
    users.add(
      {
        'uid': data['id'],
        'name': data['name'],
        'experience': data['experience'],
        'description': data['description'],
      },
    );
  }
  return users;
}