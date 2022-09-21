import 'dart:convert';

import 'package:flutter/material.dart';

import 'js_bridge.dart';

class JsBridgeUtil {
  /// 将json字符串转化成对象
  static JsBridge parseJson(String jsonStr) {
    JsBridge jsBridgeModel = JsBridge.fromMap(jsonDecode(jsonStr));
    return jsBridgeModel;
  }

  /// 向H5开发接口调用
  static executeMethod(BuildContext context, JsBridge jsBridge) async {
    if (jsBridge.method == 'getAppToken') {
      jsBridge.success.call();
    }
  }
}
