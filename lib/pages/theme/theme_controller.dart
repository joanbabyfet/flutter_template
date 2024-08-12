import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    debugPrint('初始化');
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('控制器被释放');
  }
}
