import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Application {
  // 全局路由
  static final FluroRouter router = FluroRouter();

  static navigateTo(BuildContext context, String path,
      {Map<String, dynamic>? params, TransitionType? transition}) {
    if (params != null) {
      String query = "";
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query;
        }
        query += "&$key=$value";
        index++;
      }
      path = path + query;
    }
    // print("---path=$path");
    router.navigateTo(context, path, transition: transition);
  }
}
