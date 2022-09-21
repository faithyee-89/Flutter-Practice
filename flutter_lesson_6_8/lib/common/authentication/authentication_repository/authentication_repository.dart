import 'dart:convert';
import 'package:cainiaowo/common/constant.dart';
import 'package:cainiaowo/global.dart';
import 'package:cainiaowo/models/user.dart';
import 'package:cainiaowo/utils/storage.dart';

/// uninitialized - 身份验证未初始化；  authenticated - 认证成功；  unauthenticated 认证失败
enum AuthenticationStatus { uninitialized, authenticated, unauthenticated }

class AuthenticationRepository {
  User? _user;

  User? getUser() {
    if (_user == null) {
      String? json =
          StorageUtil().getString(STORAGE_LOGIN_USER_KEY, encrypt: true);
      if (json != null) {
        Map map = jsonDecode(json);
        _user = User.fromJson(map as Map<String, dynamic>);
      }
    }
    return _user;
  }

  String? getToken() {
    return StorageUtil().getString(STORAGE_LOGIN_TOKEN_KEY, encrypt: true);
  }

  /// 缓存登录信息（token 和 user）
  void saveAuthenticationInfo(User user, String token) {
    String json = jsonEncode(user.toJson());
    StorageUtil().setString(STORAGE_LOGIN_USER_KEY, json, encrypt: true);

    StorageUtil().setString(STORAGE_LOGIN_TOKEN_KEY, token, encrypt: true);

    Global.loginToken = token;
  }

  /// 清除登录信息
  void clearAuthenticationInfo() {
    StorageUtil().remove(STORAGE_LOGIN_USER_KEY);
    StorageUtil().remove(STORAGE_LOGIN_TOKEN_KEY);
  }
}
