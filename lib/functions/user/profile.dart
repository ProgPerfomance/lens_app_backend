import 'package:mysql_client/mysql_client.dart';

Future<Map> getProfile(MySQLConnection sql, uid) async {
  final user = await sql.execute('select * from users where id =$uid');
  final userRow = user.rows.first.assoc();
  List reviewsList = [];
  List offersList = [];
  final reviews = await sql.execute("select * from reviews where uid = $uid");
  final offers = await sql.execute("select * from services where uid = $uid");
  for(var item in reviews.rows) {
    reviewsList.add({
      'rating': item.assoc()['rating'],
      'cid': item.assoc()['cid'],
      'title': item.assoc()['title'],
      'fast_work': item.assoc()['fast_work'],
      'nice_gazebo': item.assoc()['nice_gazebo'],
      'active_participation': item.assoc()['active_participation'],
    });
  }
  for(var item in offers.rows) {
    offersList.add({
      'geo_x': item.assoc()['geo_x'],
      'geo_y': item.assoc()['geo_y'],
      'cid': item.assoc()['id'],
      'title': item.assoc()['title'],
      'price': item.assoc()['fast_work'],
      'uid': item.assoc()['uid'],
      'name': item.assoc()['name'],
    });
  }
  return {
    'name': userRow['name'],
    'experience': userRow['experience'],
    'description': userRow['description'],
    'offers': offersList,
    'reviews': reviewsList,
  };
}
