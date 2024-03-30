import 'dart:convert';
import 'dart:io';
import 'package:lens_app_backend/functions/alert/request.dart';
import 'package:lens_app_backend/functions/alert/services.dart';
import 'package:lens_app_backend/functions/auth/login.dart';
import 'package:lens_app_backend/functions/auth/registration.dart';
import 'package:lens_app_backend/functions/user/profile.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'functions/user/user.dart';

void startServer() async {
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
    int response = await createUser(
        email: data['email'],
        name: data['name'],
        password: data['password'],
        description: data['description'],
        freelancer: data['freelancer'],
        experience: data['experience'],
        balance: data['balance'],
        sql: sql);
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
    var json = await request.readAsString();
    var data = await jsonDecode(json);
    await createService(sql,
        uid: data['uid'],
        geo_x: data['geo_x'],
        geo_y: data['geo_y'],
        price: data['price'],
        title: data['title']);
    return Response.ok('created');
  });
  router.get('/myLocations', (Request request) async {
    String? uid = request.url.queryParameters['uid'];
    print(uid);
    List response = await getUserLocations(sql, uid);
    return Response.ok(jsonEncode(response));
  });
  router.get('/locations', (Request request) async {
    List response = await getLocations(sql);
    return Response.ok(jsonEncode(response));
  });
  router.put('/updateBalance', (Request request) async {
    var json = await request.readAsString();
    var data = await jsonDecode(json);
    User.updateUserBalance(sql, balance: data['balance'], id: data['uid']);
    return Response.ok('');
  });
  router.get('/profile', (Request request) async {
    String? uid = request.url.queryParameters['uid'];
    print(uid);
    Map response = await getProfile(sql, uid);
    return Response.ok(jsonEncode(response));
  });
  router.get('/requests', (Request request) async {
    String? uid = request.url.queryParameters['uid'];
    List requests = await Requests().getCustomerRequests(sql, uid: uid);
    return Response.ok(requests);
  });
  HttpServer server = await serve(router, '63.251.122.116', 2314);
  print('server started');
}
