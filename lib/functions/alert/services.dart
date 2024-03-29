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

Future<List> getLocations(MySQLConnection sql) async {
  List locations = [];
  final response = await sql.execute('select * from services');
  for(var item in response.rows) {
    var data = item.assoc();
    final user = await sql.execute('select * from users where id=${data['uid']}');
    locations.add({
      'id': data['id'],
      'uid': data['uid'],
      'geo_x': data['geo_x'],
      'geo_y': data['geo_y'],
      'price': data['price'],
      'title': data['title'],
      'user_name': user.rows.first.assoc()['name'],
      'user_experience': user.rows.first.assoc()['experience'],
    });
  }
  return List.from(locations.reversed);
}

Future<List> getUserLocations(MySQLConnection sql, uid) async {
  List locations = [];
  final response = await sql.execute('select * from services where uid=$uid');
  for(var item in response.rows) {
    var data = item.assoc();
    locations.add({
      'id': data['id'],
      'uid': data['uid'],
      'geo_x': data['geo_x'],
      'geo_y': data['geo_y'],
      'price': data['price'],
      'title': data['title'],
    });
  }
  return List.from(locations.reversed);
}

Future<void> createService(MySQLConnection sql, {
  required uid,
  required geo_x,
  required geo_y,
  required price,
  required title,
}) async {
  var resul = await sql.execute(
    "SELECT * FROM services",
  );
  String id = resul.rows.last.assoc()['id'] as String;
  int idInt = int.parse(id);
  sql.execute("insert into services (id, uid, geo_x, geo_y, price, title) values (${idInt+1}, $uid, $geo_x, $geo_y, $price, '$title')");
}