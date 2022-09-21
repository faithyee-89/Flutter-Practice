import 'dart:convert';
import 'package:encrypt/encrypt.dart';

//128的keysize=16，192keysize=24，256keysize=32

class EncryptUtils {
  //Base64编码
  static String encodeBase64(String data) {
    return base64Encode(utf8.encode(data));
  }

  //Base64解码
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  // // md5 加密 32位小写
  // static String encodeMd5(String plainText) {
  //   return EncryptUtil.encodeMd5(plainText);
  // }

  /// AES加密
  static aesEncrypt(plainText, String key) {
    String iv = key.substring(0, 16);

    try {
      final _key = Key.fromUtf8(key);
      final _iv = IV.fromUtf8(iv);

      final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: _iv);
      return encrypted.base64;
    } catch (err) {
      return plainText;
    }
  }

  /// AES解密
  static dynamic aesDecrypt(encrypted, String key) {
    String iv = key.substring(0, 16);

    try {
      final _key = Key.fromUtf8(key);
      final _iv = IV.fromUtf8(iv);
      final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(encrypted, iv: _iv);
      return decrypted;
    } catch (err) {
      return encrypted;
    }
  }
}
