import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'message_controller.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget({Key? key}) : super(key: key);

  final controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('message'.tr));
  }
}
