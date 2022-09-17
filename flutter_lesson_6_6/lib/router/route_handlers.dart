import 'package:flutter_lesson_6_6/business/home/home.dart';
import 'package:flutter_lesson_6_6/business/login/login.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

Handler homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return HomePage();
});

Handler loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return LoginPage();
});

Handler emptyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return Container();
});
