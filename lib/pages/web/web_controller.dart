import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebController extends GetxController {
  String? url = Get.parameters['url'];
  String? title = Get.parameters['title'];
  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    debugPrint('初始化');

    //ios打不开http地址, 记得在Info.plist添加对http信任
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url!));
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('控制器被释放');
  }
}
