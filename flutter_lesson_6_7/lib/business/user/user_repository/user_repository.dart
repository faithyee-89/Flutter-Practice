import 'dart:async';

import 'package:uuid/uuid.dart';

import 'models/models.dart';

import 'package:cainiaowo/network/common/net_config.dart' as NetConfig;

class UserRepository {
  User _user;

  User getUser() {
    return _user;
  }

  void setUser(Map json) {
    if (json == null) return;
    Map userInfo = json['user'];
    String token = json['token'];
    if (token != null) {
      NetConfig.headers["token"] = token;
      NetConfig.options.merge(headers: NetConfig.headers);
    } 

    _user = User(userInfo['id'],
        isBindPhone: userInfo['is_bind_phone'],
        logo: userInfo['logo_url'],
        token: token,
        username: userInfo['username']);
  }
}
