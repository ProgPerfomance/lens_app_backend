import 'dart:convert';
import 'dart:io';
import 'package:lens_app_backend/functions/alert/services.dart';
import 'package:lens_app_backend/functions/auth/login.dart';
import 'package:lens_app_backend/functions/auth/registration.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'functions/user/user.dart';

void startServer()async {
  var sql = await MySQLConnection.createConnection(
      host: 'localhost',
      port: 3306,
      userName: 'root',
      password: '1234567890',
      databaseName: 'lensapp');
  await sql.connect();
  Router router = Router();
  router.post('/registration', (Request request) async {
    var json = await request.readAsString();
    var data = await jsonDecode(json);
    int response = await createUser(email: data['email'], name: data['name'], password: data['password'], description: data['description'], freelancer: data['freelancer'], experience: data['experience'], balance: data['balance'], sql: sql);
    return Response.ok(jsonEncode(response));
  });
  router.post('/login', (Request request) async {
    var json = await request.readAsString();
    print(json);
    var data = await jsonDecode(json);
    Map response = await authUser(data['email'], data['password'], sql);
    return Response.ok(jsonEncode(response));
  });
  router.post('/locations', (Request request) async {
    return Response.ok('');
  });
  router.get('/locations', (Request request) async {
    String? uid = request.url.queryParameters['uid'];
    print(uid);
    if(uid == null) {
      List response = await getLocations(sql);
      return Response.ok(jsonEncode(response));
    }
    else {
      List response = await getUserLocations(sql, uid);
      return Response.ok(jsonEncode(response));
    }
  });
  router.put('/updateBalance', (Request request) async {
    var json = await request.readAsString();
    var data = await jsonDecode(json);
    User.updateUserBalance(sql, balance: data['balance'], id: data['uid']);
    return Response.ok('');
  });
    HttpServer server = await serve(router, '63.251.122.116', 2314);
  print('server started');

}