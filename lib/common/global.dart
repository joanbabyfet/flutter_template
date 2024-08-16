import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_template/common/storage.dart';
import 'package:package_info/package_info.dart';
import '../entity/user.dart';
import '../utils/connectivity_util.dart';
import '../utils/logger_util.dart';
import '../utils/storage_util.dart';
import 'app_theme.dart';
import 'constant.dart';

// 全局配置
class Global {
  // 用户配置
  static UserProfile profile = UserProfile(token: null);
  // 是否 ios
  static bool isIOS = Platform.isIOS;
  // android 设备信息
  static late AndroidDeviceInfo androidDeviceInfo;
  // ios 设备信息
  static late IosDeviceInfo iosDeviceInfo;
  // 包信息
  static late PackageInfo packageInfo;
  // 是否第一次打开
  static bool isFirstOpen = false;
  // 是否离线登录(暂不使用)
  static bool isOfflineLogin = false;
  
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    //当前环境 dev/test/prod, 执行 flutter run --dart-define=APP_ENV=dev
    const appEnv = String.fromEnvironment('APP_ENV', defaultValue: 'dev');
    await dotenv.load(fileName: '.env.$appEnv');
    logger.i({
      '当前环境': Constant.APP_ENV,
      'API_URL：': Constant.API_BASE_URL,
    });

    // 读取设备信息
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (isIOS) {
      iosDeviceInfo = await deviceInfo.iosInfo;
    } else {
      androidDeviceInfo = await deviceInfo.androidInfo;
    }

    // 包信息
    packageInfo = await PackageInfo.fromPlatform();
    // 工具初始
    await StorageUtil.init();
    //初始化启动页面
    await initialization(null);
    //主题颜色
    await AppTheme.init();
    //网路连接检查初始化
    await ConnectivityUtil.init();

    // 读取设备第一次打开
    isFirstOpen = !StorageUtil.getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if (isFirstOpen) {
      StorageUtil.set(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }

    // 读取离线用户信息
    var profileJSON = StorageUtil.get(STORAGE_USER_PROFILE_KEY);
    if (profileJSON != null) {
      profile = UserProfile.fromJson(jsonDecode(profileJSON));
      isOfflineLogin = true;
    }
  }

  //初始化启动页面
  static Future initialization(BuildContext? context) async {
    await Future.delayed(const Duration(milliseconds: 500)); //毫秒
  }

  //持久化用户信息
  static Future<bool> saveProfile(UserProfile userResponse) {
    //写入全局用户配置
    profile = userResponse;

    String jsonString = jsonEncode(userResponse.toJson());
    //写入本地存储
    return StorageUtil.set(STORAGE_USER_PROFILE_KEY, jsonString);
  }
}