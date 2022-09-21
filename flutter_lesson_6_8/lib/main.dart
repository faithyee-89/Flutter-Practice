import 'dart:async';

import 'package:cainiaowo/common/authentication/authentication_repository/authentication_repository.dart';
import 'package:cainiaowo/global.dart';
import 'package:flutter/material.dart';
import 'package:cainiaowo/app.dart';
import 'package:bugly_crash/bugly.dart';

Future<Null> main() async {
  //一、这里配置上报APP未捕获到的异常，业务可以自由决定上报的信息
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  };

  runZonedGuarded<Future<Null>>(() async {
    Global.init().then((value) => {
          runApp(App(authenticationRepository: Global.authenticationRepository))
        });
  }, (error, stackTrace) async {
    String type = "flutter uncaught error";
    Bugly.initAndroidCrashReport(appId: "8ff1c1e8d8", isDebug: true);
    await Bugly.postException(
        type: type, error: error.toString(), stackTrace: stackTrace.toString());
  });
}
