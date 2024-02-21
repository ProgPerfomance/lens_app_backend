
import 'package:mysql_client/mysql_client.dart';

Future<Map<String, dynamic>> authUser(String email, String password, MySQLConnection sql) async {
  final response = await sql.execute(
    "SELECT * FROM users",
    {},
  );
  for (final row in response.rows) {
    var data = row.assoc();
    if (data['email'] == email && data['password_hast'] == password) {
      return {'success': true, 'uid': row.assoc()['id']};
    }
    print(row.assoc());
  }
  return {'success': false};
}
