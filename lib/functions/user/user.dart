import 'package:mysql_client/mysql_client.dart';

class User {
static  Future<void> updateUserBalance(MySQLConnection sql, {required balance, required id}) async{
    await sql.execute('update users set balance=balance+$balance where id = $id');
  }
}