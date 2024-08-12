import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_controller.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({Key? key}) : super(key: key);

  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('category'.tr));
  }
}
