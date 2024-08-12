import 'package:flutter/material.dart';
import 'package:flutter_template/pages/home/widget/activity/activity_view.dart';
import 'package:flutter_template/pages/home/widget/category/category_view.dart';
import 'package:flutter_template/pages/home/widget/index/index_view.dart';
import 'package:flutter_template/pages/home/widget/message/message_view.dart';
import 'package:flutter_template/pages/home/widget/profile/profile_view.dart';
import 'package:get/get.dart';
import '../../common/app_theme.dart';
import '../../utils/privacy_util.dart';
import '../../utils/toast_util.dart';
import 'home_controller.dart';
import 'menu_drawer_view.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  //实例化
  final controller = Get.find<HomeController>();

  List<BottomNavigationBarItem> getTabs(BuildContext context) => [
    BottomNavigationBarItem(label: 'home'.tr, icon: Icon(Icons.home)),
    BottomNavigationBarItem(label: 'category'.tr, icon: Icon(Icons.list)),
    BottomNavigationBarItem(label: 'activity'.tr, icon: Icon(Icons.local_activity)),
    BottomNavigationBarItem(label: 'message'.tr, icon: Icon(Icons.notifications)),
    BottomNavigationBarItem(label: 'profile'.tr, icon: Icon(Icons.person)),
  ];

  List<Widget> getTabWidget(BuildContext context) => [
    IndexWidget(),
    CategoryWidget(),
    ActivityWidget(),
    MessageWidget(),
    ProfileWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    //获取标签页
    var tabs = getTabs(context);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(tabs[controller.tabIndex].label!)),
        actions: [
          IconButton(
              icon: Icon(Icons.security),
              onPressed: () {
                PrivacyUtil.showPrivacyDialog(context,
                    onAgressCallback: () {
                      Get.back();
                      ToastUtil.show('agreePrivacy'.tr);
                    });
              }),
          PopupMenuButton<String>(
              itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'sponsor',
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: Icon(Icons.attach_money),
                    title: Text('sponsor'.tr),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'setting',
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: Icon(Icons.settings),
                    title: Text('setting'.tr),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'about',
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: Icon(Icons.error_outline),
                    title: Text('about'.tr),
                  ),
                ),
              ],
              onSelected: (String action) {
                Get.toNamed('/$action');
              }
            )
        ],
      ),
      body: Obx(() => IndexedStack( //显示某子组件时，将其他子组件隐藏
        index: controller.tabIndex,
        children: getTabWidget(context),
      )),
      drawer: MenuDrawerWidget(),
      //底部导航条
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        fixedColor: AppTheme.primaryColor(context),
        type: BottomNavigationBarType.fixed,
        items: tabs,
        //高亮  被点击高亮
        currentIndex: controller.tabIndex,
        //修改 页面
        onTap: (index) {
          controller.changeTabIndex(index);
        },
      )),
    );
  }
}
