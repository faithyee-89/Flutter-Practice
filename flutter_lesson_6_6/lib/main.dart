import 'package:flutter_lesson_6_6/common/application.dart';
import 'package:flutter_lesson_6_6/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson_6_6/app.dart';
import 'package:flutter_lesson_6_6/business/authentication/authentication.dart';
import 'package:flutter_lesson_6_6/business/user/user.dart';

void main() {
  // 初始化
  initialize();

  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

/// 初始化
void initialize() {
  // 初始化 路由
  Routes.configRoutes(Application.router);
}
