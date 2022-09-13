import 'dart:async';

import 'package:uuid/uuid.dart';

import 'models/models.dart';

class UserRepository {
  late User _user;

  User getUser() {
    return _user;
  }

  void setUser(Map json) {
    _user = User(json['id'],
        isBindPhone: json['is_bind_phone'],
        logo: json['logo_url'],
        token: json['token'],
        username: json['username']);
  }
}
