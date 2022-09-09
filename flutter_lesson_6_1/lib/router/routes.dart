
import 'package:flutter_lesson_6_1/router/route_handlers.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static String home = "/";
  static String login = "/login";

  static void configRoutes(FluroRouter router) {
    router.notFoundHandler = emptyHandler;
  }
}