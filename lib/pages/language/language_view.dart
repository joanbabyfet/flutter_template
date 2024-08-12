import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/app_theme.dart';
import '../../lang/translation_service.dart';
import '../../utils/logger_util.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = AppTheme.primaryColor(context);

    Widget _buildItem(String title, String value) {
      var list = value.split('_');
      var locale = Locale(list[0], list[1]);
      //用户当前语言
      var userLocale = Locale(Get.locale!.languageCode, Get.locale!.countryCode);

      return ListTile(
        title: Text(
          title,
          // 对APP当前语言进行高亮显示
          style: TextStyle(color: userLocale == locale ? color : null),
        ),
        trailing: userLocale == locale ? Icon(Icons.done, color: color) : null,
        onTap: () {
          // 此行代码会通知MaterialApp重新build
          Get.updateLocale(locale); //切换语言
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('language'.tr)),
      body: ListView(
        children: [
          _buildItem('english'.tr, 'en_US'),
          _buildItem('zh_cn'.tr, 'zh_CN'),
          _buildItem('zh_tw'.tr, 'zh_TW'),
        ],
      )
    );
  }
}
