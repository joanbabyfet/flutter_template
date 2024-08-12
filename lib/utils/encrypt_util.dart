import 'dart:convert';
import 'package:crypto/crypto.dart';

//加密工具类
class EncryptUtil {
  // SHA256
  String SHA256(String input) {
    String salt = 'EIpWsyfiy@R@X#qn17!StJNdZK1fFF8iV6ffN!goZkqt#JxO'; // 加盐
    var bytes = utf8.encode(input + salt);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}