import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'activity_controller.dart';

class ActivityWidget extends StatelessWidget {
  ActivityWidget({Key? key}) : super(key: key);

  final controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('activity'.tr));
  }
}
