import 'package:cainiaowo/router/route_handlers.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static String home = "/";
  static String login = "/login";
  static String courseDetail = "/courseDetail";
  static String lessonPlay = "/lessonPlay";
  static String webViewPage = "/webViewPage";

  static void configRoutes(FluroRouter router) {
    router.define(home, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.define(courseDetail, handler: courseDetailHandler);
    router.define(lessonPlay, handler: lessonPlayHandler);
    router.define(webViewPage, handler: webViewPageHandler);
    router.notFoundHandler = emptyHandler;
  }
}
