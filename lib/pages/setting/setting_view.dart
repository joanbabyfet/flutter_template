import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../route/app_routes.dart';
import 'setting_controller.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('setting'.tr)),
        body: SingleChildScrollView(
          child: ListBody(children: [
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('theme'.tr),
              trailing: Icon(Icons.keyboard_arrow_right),
              contentPadding: EdgeInsets.only(left: 20, right: 10),
              onTap: () {
                Get.toNamed(AppRoutes.Theme);
              }),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('language'.tr),
              trailing: Icon(Icons.keyboard_arrow_right),
              contentPadding: EdgeInsets.only(left: 20, right: 10),
              onTap: () {
                Get.toNamed(AppRoutes.Language);
              },
            ),
          ]
        )
      )
    );
  }
}
