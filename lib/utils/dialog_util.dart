import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogUtil{
  //对话框
  static Future<bool?> showConfimDialog(BuildContext context,String content) {
    return Get.defaultDialog(
      title: '提示',
      content: Text(content),
      textConfirm: '确认',
      textCancel: '取消',
      onConfirm: () => Get.back(result: true),
    );
  }
}