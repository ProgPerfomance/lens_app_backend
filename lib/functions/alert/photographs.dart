import 'package:mysql_client/mysql_client.dart';

Future<List> getPhotographsList (MySQLConnection sql) async{
  List users = [];
  final response = await sql.execute("select * from users where freelancer = 1");
  for (var item in response.rows) {
    users.add({
      'name': item.assoc()['name'],
      'experience': item.assoc()['experience'],
      'description': item.assoc()['description'],
    });
  }
  return users;
}