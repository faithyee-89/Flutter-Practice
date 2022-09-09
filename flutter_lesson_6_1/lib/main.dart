import 'package:flutter/material.dart';
import 'package:flutter_lesson_6_1/router/routes.dart';

import 'common/application.dart';

void main() {

  // 初始化
  initialize();

  runApp(const MaterialApp(
    home: Scaffold(
      
    ),
  ));
}

/// 初始化
void initialize() {
  // 初始化 路由
  Routes.configRoutes(Application.router);
}