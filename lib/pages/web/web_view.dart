import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/pages/web/web_controller.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatelessWidget {
  WebPage({Key? key}) : super(key: key);

  final controller = Get.put(WebController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title!, style: TextStyle(fontSize: 15)),
        titleSpacing: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                //开启分享功能
                Share.share(controller.url!);
              }
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: WebViewWidget(controller: controller.webViewController)),
        ],
      ),
    );
  }
}
