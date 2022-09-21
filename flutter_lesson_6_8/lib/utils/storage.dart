import 'dart:convert';
import 'package:cainiaowo/common/constant.dart';
import 'package:cainiaowo/libs/encrypt_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储
class StorageUtil {
  StorageUtil._internal();
  static final StorageUtil _instance = StorageUtil._internal();

  factory StorageUtil() {
    return _instance;
  }

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool>? setString(String key, String value, {bool encrypt: false}) {
    // if (value == null || value == "") return  Future.error(new Error());

    if (encrypt) {
      value = EncryptUtils.aesEncrypt(value, SECRET_KEY);
    }
    return _prefs?.setString(key, value);
  }

  String? getString(String key, {bool encrypt: false}) {
    String? str = _prefs?.getString(key);
    if (encrypt && str != null) {
      str = EncryptUtils.aesDecrypt(str, SECRET_KEY);
    }
    return str;
  }

  Future<bool>? setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _prefs?.setString(key, jsonString);
  }

  dynamic getJSON(String key) {
    String? jsonString = _prefs?.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool>? setBool(String key, bool val) {
    return _prefs?.setBool(key, val);
  }

  bool getBool(String key) {
    bool? val = _prefs?.getBool(key);
    return val == null ? false : val;
  }

  Future<bool>? remove(String key) {
    return _prefs?.remove(key);
  }
}
