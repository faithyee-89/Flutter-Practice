import 'package:flutter_lesson_6_6/network/common/net_manager.dart';
import 'package:flutter_lesson_6_6/network/index/net_index_path.dart';
import 'package:dio/dio.dart';

class CNWIndexNetManager {
  // 首页banner 图的接口实现
  static Future<List> bannerList({int? type, int? pageShow}) async {
    Map<String, dynamic> queryParameters = {};
    if (type != null) queryParameters['type'] = type;
    if (pageShow != null) queryParameters['page_show'] = pageShow;

    List list = await CNWNetManager.get<List>(
      net_index_path_bannerlist,
      queryParameters: queryParameters,
    );
    return list;
  }

  // 首页模块列表接口实现
  static Future<List> moduleList() async {
    List list = await CNWNetManager.get<List>(
      net_index_path_modulelist,
    );
    return list;
  }

  // 首页 模块详情列表接口实现
  static Future<List> componentList(int moduleId, int type) async {
    if (moduleId == null || type == null) {
      Response response = Response(statusCode: 404, data: {
        "errorCode": '-1',
        "errorMsg": 'moudleId or type can not be null.'
      });
      return response.data;
    }

    Map<String, dynamic> queryParameters = {
      'module_id': moduleId ?? '',
      'module_type': type ?? ''
    };

    List list = await CNWNetManager.get<List>(
      net_index_path_componentlist,
      queryParameters: queryParameters,
    );
    return list;
  }
}
