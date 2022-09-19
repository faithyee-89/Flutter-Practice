import 'package:cainiaowo/common/application.dart';
import 'package:cainiaowo/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:cainiaowo/app.dart';
import 'package:cainiaowo/business/authentication/authentication.dart';
import 'package:cainiaowo/business/user/user.dart';

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
