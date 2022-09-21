import 'package:cainiaowo/libs/http/http_manager.dart';
import 'package:cainiaowo/models/adbanner.dart';
import 'package:cainiaowo/api/index/net_index_path.dart';
import 'package:cainiaowo/models/page_module.dart';

class CNWIndexNetManager {
  // 首页banner 图的接口实现
  static Future<List<AdBanner>> bannerList({int? type, int? pageShow}) {
    Map<String, dynamic> params = {};
    params['type'] = type;
    params['page_show'] = pageShow;

    return HttpManager.get(net_index_path_bannerlist, params: params).then(
        (value) => List<Map>.from(value)
            .map((dynamic e) => AdBanner.fromJson(e))
            .toList());
  }

  // 首页模块列表接口实现
  static Future<List<PageModule>> moduleList() {
    return HttpManager.get(net_index_path_modulelist, params: {"page_id": 1})
        .then((value) => List<Map>.from(value)
            .map((dynamic e) => PageModule.fromJson(e))
            .toList());
  }

  // 首页 模块详情列表接口实现
  static Future<List> componentList(int moduleId, int type) {
    Map<String, dynamic> queryParameters = {
      'module_id': moduleId,
      'module_type': type
    };

    return HttpManager.get(
      net_index_path_componentlist,
      params: queryParameters,
    ).then((value) {
      return value;
    });
  }
}
