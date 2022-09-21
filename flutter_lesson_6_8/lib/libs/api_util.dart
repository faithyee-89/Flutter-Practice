import 'dart:convert';

import 'package:crypto/crypto.dart';

class ApiUtil {
  String getSign(Map<String, dynamic> params, String appKey, String path) {
    if (params.containsKey("sign")) {
      params.remove("sign");
    }
    // 过滤空值
    params.removeWhere((key, value) => value == null);

    List<String> sortedKeys = params.keys.toList();
    //  ASCII 排序
    sortedKeys.sort();

    var sortedMap = Map();
    sortedKeys.forEach((element) {
      sortedMap[element] = params[element];
    });

    String paramsQueryStr = "";
    sortedMap.forEach((key, value) {
      paramsQueryStr += "$key=$value&";
    });

    paramsQueryStr += "appkey=$appKey&path=$path";

    String sign =
        md5.convert(utf8.encode(paramsQueryStr)).toString().toUpperCase();

    return sign;
  }
}
