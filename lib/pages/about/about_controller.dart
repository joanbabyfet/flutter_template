import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../common/global.dart';

class AboutController extends GetxController {
  final _versionName = ''.obs; //版本号

  //该字段可公开访问
  get versionName => _versionName.value;

  @override
  void onInit() {
    super.onInit();
    debugPrint('初始化');

    _versionName.value = Global.packageInfo.version;
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('控制器被释放');
  }
}
