import 'package:cainiaowo/pages/main_laout/view/index.dart';
import 'package:cainiaowo/pages/webview/index.dart';
import 'package:cainiaowo/pages/course_detail/view/index.dart';
import 'package:cainiaowo/pages/login/login.dart';
import 'package:cainiaowo/pages/play/view/index.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

Handler homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return MainLayout();
});

Handler loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return LoginPage();
});

Handler courseDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return CourseDetailPage(
    courseId: int.parse(parameters['courseId']![0]),
  );
});

Handler lessonPlayHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return LessonPlayPage(
    courseId: int.parse(parameters['courseId']![0]),
    lessonKey: parameters['lessonKey']?[0],
  );
});

Handler webViewPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return WebViewPage(
    url: parameters["url"]![0],
    title: parameters["title"]?.first,
    isLocalUrl: false,
  );
});

Handler emptyHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return Container();
});
