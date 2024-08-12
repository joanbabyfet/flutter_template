import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../common/app_theme.dart';
import '../../utils/xupdate_util.dart';

class HomeController extends GetxController {
  final _tabIndex = 0.obs;

  //该字段可公开访问
  get tabIndex => _tabIndex.value;

  void changeTabIndex(int index) {
    _tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('初始化');

    //检查app版本
    XUpdateUtil.initAndCheck();
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('控制器被释放');
  }
}
