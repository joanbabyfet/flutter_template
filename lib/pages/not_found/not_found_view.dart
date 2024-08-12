import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'not_found_controller.dart';

class NotFoundPage extends StatelessWidget {
  NotFoundPage({Key? key}) : super(key: key);

  //实例化
  final controller = Get.put(NotFoundController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text('Not Found'))
    );
  }
}
