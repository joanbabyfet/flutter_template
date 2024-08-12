import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_template/utils/utils.dart';
import 'dart:io';
import 'package:get/get.dart';
import '../common/app_theme.dart';
import '../common/global.dart';

//隐私弹窗工具
class PrivacyUtil {
  PrivacyUtil._internal();

  //隐私服务政策地址
  static const PRIVACY_URL = 'https://raw.githubusercontent.com/joanbabyfet/life_vue3/master/LICENSE';

  static void showPrivacyDialog(BuildContext context, {VoidCallback? onAgressCallback}) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('reminder'.tr),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('welcome'.trParams({'appName': Global.packageInfo.appName})),
                  SizedBox(height: 5),
                  Text('welcome1'.tr),
                  SizedBox(height: 5),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: 'welcome2'.tr),
                    TextSpan(
                        text: 'privacyName'.trParams({'appName': Global.packageInfo.appName}),
                        style: TextStyle(color: AppTheme.primaryColor(context)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Utils.goWeb(PRIVACY_URL, 'privacyName'.trParams({'appName': Global.packageInfo.appName}));
                          }),
                    TextSpan(text: 'welcome3'.tr),
                  ])),
                  SizedBox(height: 5),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: 'welcome4'.tr),
                    TextSpan(
                        text: 'privacyName'.trParams({'appName': Global.packageInfo.appName}),
                        style: TextStyle(color: AppTheme.primaryColor(context)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Utils.goWeb(PRIVACY_URL, 'privacyName'.trParams({'appName': Global.packageInfo.appName}));
                          }),
                    TextSpan(text: 'welcome5'.tr),
                  ])),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('disagree'.tr),
                onPressed: () {
                  Get.back();
                  showPrivacySecond(context,
                      onAgressCallback: onAgressCallback);
                },
              ),
              TextButton(
                child: Text('agree'.tr),
                onPressed: onAgressCallback == null
                    ? () {
                  Get.back();
                }
                    : onAgressCallback,
              ),
            ],
          );
        },
      );
  }

  //第二次提醒
  static void showPrivacySecond(BuildContext context, {VoidCallback? onAgressCallback}) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('reminder'.tr),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('privacyExplainAgain'.trParams({'appName': Global.packageInfo.appName})),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('stillDisagree'.tr),
                onPressed: () {
                  Get.back();
                  showPrivacyThird(context, onAgressCallback: onAgressCallback!);
                },
              ),
              TextButton(
                child: Text('lookAgain'.tr),
                onPressed: () {
                  Get.back();
                  showPrivacyDialog(context,
                      onAgressCallback: onAgressCallback);
                },
              ),
            ],
          );
        },
      );
  }

  //第三次提醒
  static void showPrivacyThird(BuildContext context, {VoidCallback? onAgressCallback}) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('thinkAboutItAgain'.tr),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('exitApp'.tr),
                onPressed: () {
                  //退出整个app程序
                  exit(0); //建议该写法, 苹果原生方法
                },
              ),
              TextButton(
                child: Text('lookAgain'.tr),
                onPressed: () {
                  Get.back();
                  showPrivacyDialog(context,
                      onAgressCallback: onAgressCallback);
                },
              ),
            ],
          );
        },
      );
  }
}