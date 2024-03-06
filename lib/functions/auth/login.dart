import 'package:mysql_client/mysql_client.dart';

Future<Map<String, dynamic>> authUser(
    String email, String password, MySQLConnection sql) async {

  try {
    final user = await sql.execute("SELECT * FROM users where email = '$email' and password_hast = '$password", {}, );
    print(user.rows.first.assoc()['name']);
    var  data = (user.rows.first.assoc());
    return {'success': true, 'uid': data['id'], 'name': data['name'], 'email': data['email'], 'freelancer': data['freelancer'], 'balance': data['balance']};
  } catch (e) {}
  return {'success': false};
}
