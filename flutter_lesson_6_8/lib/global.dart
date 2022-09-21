import 'dart:io';

import 'package:cainiaowo/common/application.dart';
// import 'package:cainiaowo/config.dart';
import 'package:cainiaowo/common/authentication/authentication_repository/authentication_repository.dart';
import 'package:cainiaowo/common/constant.dart';
import 'package:cainiaowo/common/providers/appstate.dart';
import 'package:cainiaowo/libs/http/http_manager.dart';
import 'package:cainiaowo/router/routes.dart';
import 'package:cainiaowo/utils/storage.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

/// 全局配置
class Global {
  /// 是否 ios
  static bool isIOS = Platform.isIOS;

  /// android 设备信息
  static AndroidDeviceInfo? androidDeviceInfo;

  /// ios 设备信息
  static IosDeviceInfo? iosDeviceInfo;

  /// 包信息
  static PackageInfo? packageInfo;

  /// 是否第一次打开
  static bool isFirstOpen = false;

  /// 是否离线登录
  static bool isOfflineLogin = false;

  /// 用户登录后的token
  static String? loginToken;

  /// 应用状态,
  static AppState appState = AppState();

  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static AuthenticationRepository authenticationRepository =
      new AuthenticationRepository();

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    // 本地数据存储工具初始
    await StorageUtil().init();

    // // 读取设备第一次打开
    isFirstOpen = !StorageUtil().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if (isFirstOpen) {
      StorageUtil().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }

    // 读取离线用户信息
    var token = authenticationRepository.getToken();
    if (token != "") {
      loginToken = token;
      isOfflineLogin = true;
    }

    // 包信息
    Global.packageInfo = await PackageInfo.fromPlatform();

    // 读取设备信息
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (isIOS) {
      Global.iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      // if (isRelease) initBuglyiOS();
    } else {
      Global.androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      // if (isRelease) initBuglyAndroid();
    }

    // 初始化 路由
    Routes.configRoutes(Application.router);

    // 初始化网络请求

    HttpManager.init(isIOS);

    // Android 沉浸式状态栏
    if (Platform.isAndroid) {
      SystemUiOverlayStyle style = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,

          ///这是设置状态栏的图标和字体的颜色
          ///Brightness.light  一般都是显示为白色
          ///Brightness.dark 一般都是显示为黑色
          statusBarIconBrightness: Brightness.light);
      SystemChrome.setSystemUIOverlayStyle(style);
    }
  }

  //   // 持久化 用户信息
  // static Future<bool> saveProfile(UserLoginResponseEntity userResponse) {
  //   profile = userResponse;
  //   return StorageUtil()
  //       .setJSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  // }

  static void initBuglyAndroid() {
    // 初始化 Bugly
    // Bugly.initAndroidCrashReport(appId: "xxxxx", isDebug: false);
    // Bugly.setAndroidAppPackage(appPackage: packageInfo?.packageName);
    // Bugly.setAppVersion(appVersion: packageInfo?.version);
    // // Bugly.setAndroidAppChannel(appChannel: "test");

    // //bugly自定义日志,可在"跟踪日志"页面查看
    // BuglyLog.d(tag: "bugly", content: "debugvalue");
    // BuglyLog.i(tag: "bugly", content: "infovalue");
    // BuglyLog.v(tag: "bugly", content: "verbosevalue");
    // BuglyLog.w(tag: "bugly", content: "warnvalue");
    // BuglyLog.e(tag: "bugly", content: "errorvalue");
  }

  static void initBuglyiOS() {
    // 初始化 Bugly
    // Bugly.initAndroidCrashReport(appId: "xxxxx", isDebug: false);

    // Bugly.setAppVersion(appVersion: packageInfo?.version);
    // Bugly.setUserId(userId: "iosuser");
    // BuglyLog.d(tag: "bugly", content: "debugvalue");
    // BuglyLog.i(tag: "bugly", content: "infovalue");
    // BuglyLog.w(tag: "bugly", content: "warnvalue");
    // BuglyLog.v(tag: "bugly", content: "verbosevalue");
    // BuglyLog.e(tag: "bugly", content: "errorvalue");
  }
}
