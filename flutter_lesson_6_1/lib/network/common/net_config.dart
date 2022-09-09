import 'package:dio/dio.dart';

const String baseUrl = "https://course.api.cniao5.com";
const int connectTimeout = 5000;
const int receiveTimeout = 3000;

final Map<String, dynamic> headers = <String, dynamic>{'platform': 'yapi'};

final BaseOptions options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
    headers: headers);
