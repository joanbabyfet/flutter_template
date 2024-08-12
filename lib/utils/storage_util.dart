import 'package:shared_preferences/shared_preferences.dart';

//本地存储
class StorageUtil {
  static final StorageUtil _instance = StorageUtil._internal();
  factory StorageUtil() => _instance;
  StorageUtil._internal(); //私有构造函数（命名构造函数）

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  //dynamic为动态类型
  static Future<bool> set(String key, dynamic value) {
    if (value is String) {
      return _prefs!.setString(key, value);
    } else if (value is int) {
      return _prefs!.setInt(key, value);
    } else if (value is double) {
      return _prefs!.setDouble(key, value);
    } else if (value is bool) {
      return _prefs!.setBool(key, value);
    }
    return _prefs!.setStringList(key, value);
  }

  static dynamic get(String key) {
    return _prefs!.get(key);
  }

  static bool getBool(String key) {
    return _prefs!.getBool(key) ?? false;
  }

  static Future<bool> cleanAll() async {
    return _prefs!.clear();
  }

  static Future<bool> remove(String key) async {
    return _prefs!.remove(key);
  }

  static bool containsKey(String key) {
    return _prefs!.containsKey(key);
  }

  static Future<Map<String, String>> getAll_prefs() async {
    return <String, String>{
      for (String key in _prefs!.getKeys()) ...{key: _prefs!.get(key).toString()}
    };
  }
}