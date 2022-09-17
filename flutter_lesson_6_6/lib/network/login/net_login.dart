import 'dart:convert';

import 'package:flutter_lesson_6_6/network/common/net_manager.dart';
import 'package:flutter_lesson_6_6/network/login/net_login_path.dart';
import 'package:dio/dio.dart';

class CNWLoginNetManager {
  static Future<Map> login(String account, String password) async {
    if (account == null || password == null) {
      Response response = Response(statusCode: 404, data: {
        "errorCode": '-1',
        "errorMsg": 'account or password can not be null.'
      });
      return response.data;
    }
    Map<String, dynamic> queryParameters = {
      'mobi': '18648957777',
      'password': 'cn5123456',
    };
    Map resData = await CNWNetManager.post<Map>(
      net_login_path_login,
      data: jsonEncode(queryParameters),
    );
    return resData;
  }
}
