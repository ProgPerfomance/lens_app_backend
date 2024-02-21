import 'dart:convert';
import 'dart:io';
import 'package:lens_app_backend/functions/auth/registration.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

void startServer()async {
  Router router = Router();
  router.post('/registration', (Request request) async {
    var json = await request.readAsString();
    var data = await jsonDecode(json);
    await createUser(email: data['email'], name: data['name'], password: data['password'], description: data['description'], freelancer: data['freelancer'], experience: data['experience'], balance: data['balance']);
    return Response.ok('');
  });
  router.post('/locations', (Request request) async {
    return Response.ok('');
  });
  router.get('/locations', (Request request) async {
    String? city = request.url.queryParameters['city'];
    print(city);
   return Response.ok('город $city');
  });
    HttpServer server = await serve(router, 'localhost', 2314);
  print('server started');
}