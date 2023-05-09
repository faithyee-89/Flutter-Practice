import 'dart:convert';

import 'package:dio/dio.dart';

import '../common/net_manager.dart';
import '../profile/net_profile_path.dart';

class CNWLoginNetManager {
  static Future<Map> login(String account, String password) async {
    if (account == null || password == null) {
      Response response = Response(
          statusCode: 404,
          data: {
            "errorCode": '-1',
            "errorMsg": 'account or password can not be null.'
          },
          requestOptions: RequestOptions());
      return response.data;
    }
    Map<String, dynamic> queryParameters = {
      'mobi': '18680333215',
      'password': 'yw2633275',
    };
    Response response = await CNWNetManager.post(
      net_login_path_login,
      data: jsonEncode(queryParameters),
    );
    return response.data;
  }
}
