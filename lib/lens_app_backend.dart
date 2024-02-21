import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

void startServer()async {
  Router router = Router();
  router.post('/registration', (Request request) async {
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