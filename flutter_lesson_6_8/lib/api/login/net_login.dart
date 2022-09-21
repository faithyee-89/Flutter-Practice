import 'package:cainiaowo/libs/http/http_manager.dart';
import 'package:cainiaowo/models/user.dart';
import 'package:cainiaowo/api/login/net_login_path.dart';

class CNWLoginNetManager {
  static Future<LoginInfo> login(String account, String password) async {
    Map<String, dynamic> data = {
      'mobi': account,
      'password': password,
    };

    return HttpManager.post(net_login_path_login, data: data).then((value) {
      LoginInfo response = LoginInfo.fromJson(value);
      return response;
    });
  }
}
