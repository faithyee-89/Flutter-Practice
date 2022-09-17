import 'package:flutter_lesson_6_6/router/route_handlers.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static String home = "/";
  static String login = "/login";

  static void configRoutes(FluroRouter router) {
    router.define(home, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.notFoundHandler = emptyHandler;
  }
}
