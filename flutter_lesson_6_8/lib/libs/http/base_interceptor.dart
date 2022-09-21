import 'dart:convert';

import 'package:cainiaowo/config.dart';
import 'package:cainiaowo/global.dart';
import 'package:cainiaowo/libs/api_util.dart';
import 'package:cainiaowo/libs/encrypt_util.dart';
import 'package:dio/dio.dart';
import 'base_response.dart';

class BaseResponseInterceptor extends Interceptor {
  static const int SUCCESS = 1;

  ApiConfig apiConfig = Global.isIOS
      ? Env.envConfig.iOSApiConfig
      : Env.envConfig.androidApiConfig;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map<String, dynamic>? requestData = options.data;
    Map<String, dynamic> requestParams = options.queryParameters;

    Map<String, dynamic> allParams = {};

    Map<String, dynamic> headerParams = apiConfig.header;

    if (requestData != null) allParams.addAll(requestData);

    // ignore: unnecessary_null_comparison
    if (requestParams != null) allParams.addAll(requestParams);

    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    headerParams["timestamp"] = timestamp;

    // 添加token
    if (Global.loginToken != null) {
      headerParams["token"] = Global.loginToken;
    }

    allParams.addAll(headerParams);

    String path = options.path;
    String sign = ApiUtil().getSign(allParams, apiConfig.appKey, path);
    headerParams["sign"] = sign;
    options.headers = headerParams;

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map data = response.data;
    int code = data["code"];
    if (code != SUCCESS) {
      handler.reject(DioError(
          requestOptions: response.requestOptions, response: response));
    } else {
      String? dataStr = data["data"];
      if (dataStr != null || dataStr != "") {
        dataStr = EncryptUtils.aesDecrypt(dataStr, apiConfig.appKey);
      }
      response.data = BaseResponse(
          code: data["code"],
          message: data["message"],
          data: jsonDecode(dataStr!));
      handler.next(response);
    }
  }

  // 在 http.dart 中处理错误逻辑

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   print("调用 拦截器 onError");
  //   // error统一处理
  //   ApiException apiException = ApiException.create(err);
  //   EasyLoading.showError(apiException.message);
  //   err.error = apiException;
  //   handler.next(err);
  // }
}
