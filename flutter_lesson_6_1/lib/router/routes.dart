
import 'package:fluro/fluro.dart';
import 'package:flutter_lesson_6_1/router/route_handlers.dart';

class Routes {
  static String home = "/";
  static String login = "/login";

  static void configRoutes(FluroRouter router) {
    router.define(home, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.notFoundHandler = emptyHandler;
  }
}