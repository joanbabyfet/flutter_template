import 'dart:io';
import 'package:flutter_template/utils/toast_util.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';
import 'logger_util.dart';

//版本更新工具
class XUpdateUtil {
  XUpdateUtil._internal();

  //版本更新检查的地址
  static const String UPDATE_URL = '';

  static void initAndCheck() {
    if (Platform.isAndroid) {
      init(url: UPDATE_URL);
    }
  }

  //初始化XUpdate
  static void init({String url = ''}) {
    FlutterXUpdate.init(
        debug: true,
        enableRetry: true,
        retryContent: 'Github下载速度太慢了，是否考虑切换xxx下载？',
        retryUrl: 'https://example.com/flutter_template').then((result) {
        if (url.isNotEmpty) {
          checkUpdate(url);
        }
    });
    FlutterXUpdate.setErrorHandler(
      onUpdateError: (Map<String, dynamic>? message) async {
        //2004是无最新版本
        if (message?['code'] != 2004) {
          //4000是下载失败
          if (message?['code'] == 4000) {
            FlutterXUpdate.showRetryUpdateTipDialog(
                retryContent: 'Github被墙无法继续下载，是否考虑切换xxx下载？',
                retryUrl: 'https://example.com/flutter_template');
          } else {
            ToastUtil.show(message?['detailMsg']);
          }
        }
      }
    );
  }

  //检查更新
  static void checkUpdate(String? url) {
    if (url != null && url.isNotEmpty) {
      FlutterXUpdate.checkUpdate(url: url, widthRatio: 0.7);
    }
  }

  //检查更新
  static void checkUpdateWithErrorTip({String url = UPDATE_URL}) {
    FlutterXUpdate.setErrorHandler(
      onUpdateError: (Map<String, dynamic>? message) async {
        logger.i(message);
        //4000是下载失败
        if (message?['code'] == 4000) {
          FlutterXUpdate.showRetryUpdateTipDialog(
              retryContent: 'Github被墙无法继续下载，是否考虑切换xxx下载？',
              retryUrl: 'https://example.com/flutter_template');
        } else {
          ToastUtil.show(message?['message']);
        }
      }
    );
    checkUpdate(url);
  }
}