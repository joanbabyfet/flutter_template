import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'en_US.dart';
import 'zh_CN.dart';
import 'zh_TW.dart';

class TranslationService extends Translations {
  //当前系统语言
  static Locale? get locale => Get.deviceLocale;
  //找不到对应字典时默认为英文
  static final fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    'zh_CN': zh_CN,
    'zh_TW': zh_TW,
  };
}