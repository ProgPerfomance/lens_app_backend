import 'package:mysql_client/mysql_client.dart';

Future<Map<String, dynamic>> authUser(
    String email, String password, MySQLConnection sql) async {

  try {
    final user = await sql.execute("SELECT * FROM users where email = '$email' and password_hast = '$password'", {}, );
  var  data = (user.rows.first.assoc());
    return {'success': true, 'uid': data['id']};
  } catch (e) {}
  return {'success': false};
}
