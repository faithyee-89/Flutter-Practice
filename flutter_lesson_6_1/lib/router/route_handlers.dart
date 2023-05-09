import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../business/home/view/home_page.dart';
import '../business/login/view/login_page.dart';

Handler homeHandler =
    Handler(handlerFunc: (context, Map<String, List<String>> parameters) {
  return HomePage();
});

Handler loginHandler =
    Handler(handlerFunc: (context, Map<String, List<String>> parameters) {
  return LoginPage();
});

Handler emptyHandler =
    Handler(handlerFunc: (context, Map<String, List<String>> parameters) {
  return Container();
});
