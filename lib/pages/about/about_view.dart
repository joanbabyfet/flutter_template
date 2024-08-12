import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/app_theme.dart';
import '../../utils/utils.dart';
import '../../utils/xupdate_util.dart';
import '../../widget/list_item.dart';
import 'about_controller.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);

  final controller = Get.put(AboutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('about'.tr)),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 60),
                child: FlutterLogo(size: 80)),
            Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Center(
                    child: Text('${'version_name'.tr}: ${controller.versionName}', style: TextStyle(color: Colors.grey[600], fontSize: 17))
                )
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(15.0),
              child: Card(
                color: AppTheme.primaryColor(context),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListItem(
                        icon: Icon(Icons.assignment_ind, color: Colors.white),
                        title: 'author'.tr,
                        titleColor: Colors.white,
                        describe: 'alan',
                        describeColor: Colors.white,
                        onPressed: () {
                          //打开浏览器
                          Utils.launch('https://github.com/joanbabyfet');
                        },
                      ),
                      ListItem(
                        icon: Icon(Icons.supervised_user_circle, color: Colors.white),
                        title: 'telegram'.tr,
                        titleColor: Colors.white,
                        describe: '@bluemountain168',
                        describeColor: Colors.white,
                        onPressed: () {
                          //打开浏览器
                          Utils.launch('https://t.me/bluemountain168');
                        },
                      ),
                      ListItem(
                        icon: Icon(Icons.http, color: Colors.white),
                        title: 'Github',
                        titleColor: Colors.white,
                        describe: 'https://github.com/joanbabyfet/flutter_template',
                        describeColor: Colors.white,
                        onPressed: () {
                          //打开浏览器
                          Utils.launch('https://github.com/joanbabyfet/flutter_template');
                        },
                      ),
                      ListItem(
                        icon: Icon(Icons.update, color: Colors.white),
                        title: 'appupdate'.tr,
                        titleColor: Colors.white,
                        describeColor: Colors.white,
                        onPressed: () {
                          XUpdateUtil.checkUpdateWithErrorTip();
                        },
                      )
                    ],
                  ),
                )
              ),
            ),
          ]
        )
      )
    );
  }
}
