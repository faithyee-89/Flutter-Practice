import 'package:flutter/material.dart';
import 'package:flutter_lesson_6_1/router/routes.dart';

import 'App.dart';
import 'business/authentication/authentication_repository/authentication_repository.dart';
import 'business/user/user_repository/user_repository.dart';
import 'common/application.dart';
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