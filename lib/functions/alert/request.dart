import 'package:mysql_client/mysql_client.dart';

class Requests {
  Future<List> getCustomerRequests(MySQLConnection sql, {required uid}) async {
    List requestList = [];
    final requests = await sql.execute("select* from requests where uid=$uid");
    for(var item in requests.rows) {
      var data = item.assoc();
      requestList.add({
        'id': data['id'],
        'cid': data['cid'],
        'price': data['price'],
        'approve_freelancer': data['approve_freelancer'],
        'approve_customer': data['approve_customer'],
        'review_customer': data['review_customer'],
        'review_freelancer': data['review_freelancer'],
        'status': data['status'],
        'freelancer_id': data['freelancer_id'],
      });
    }
   return requestList;
  }
  Future<void> sendRequest () async{}
}