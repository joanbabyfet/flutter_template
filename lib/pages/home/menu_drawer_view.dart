import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/app_theme.dart';
import '../../common/global.dart';
import '../../route/app_routes.dart';
import '../../utils/authentication.dart';
import '../../utils/toast_util.dart';
import '../login/login_view.dart';
import 'home_controller.dart';

class MenuDrawerWidget extends StatelessWidget {
  MenuDrawerWidget({Key? key}) : super(key: key);

  //实例化
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    Color color = AppTheme.primaryColor(context);

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                color: AppTheme.primaryColor(context),
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipOval(
                        // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                        child: FlutterLogo(
                          size: 80,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Global.profile.realname != null
                            ? Global.profile.realname!
                            : 'title'.tr,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                      )
                    )
                  ],
                ),
              ),
              onTap: () {
                ToastUtil.show('点击头像');
              },
            ),
            MediaQuery.removePadding(
              context: context,
              // DrawerHeader consumes top MediaQuery padding.
              removeTop: true,
              child: Obx(() => ListView(
                shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                scrollDirection: Axis.vertical, // 水平listView
                children: [
                  //首页
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('home'.tr),
                    onTap: () {
                      controller.changeTabIndex(0);
                      Get.back(); //关闭对话框
                    },
                    selectedColor: color,
                    selected: controller.tabIndex == 0,
                  ),
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text('category'.tr),
                    onTap: () {
                      controller.changeTabIndex(1);
                      Get.back();
                    },
                    selectedColor: color,
                    selected: controller.tabIndex == 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.local_activity),
                    title: Text('activity'.tr),
                    onTap: () {
                      controller.changeTabIndex(2);
                      Get.back();
                    },
                    selectedColor: color,
                    selected: controller.tabIndex == 2,
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('message'.tr),
                    onTap: () {
                      controller.changeTabIndex(3);
                      Get.back();
                    },
                    selectedColor: color,
                    selected: controller.tabIndex == 3,
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('profile'.tr),
                    onTap: () {
                      controller.changeTabIndex(4);
                      Get.back();
                    },
                    selectedColor: color,
                    selected: controller.tabIndex == 4,
                  ),
                  //设置、关于、赞助
                  Divider(height: 1.0, color: Colors.grey),
                  ListTile(
                    leading: Icon(Icons.attach_money),
                    title: Text('sponsor'.tr),
                    onTap: () {
                      Get.toNamed(AppRoutes.Sponsor);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('setting'.tr),
                    onTap: () {
                      Get.toNamed(AppRoutes.Setting);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.error_outline),
                    title: Text('about'.tr),
                    onTap: () {
                      Get.toNamed(AppRoutes.About);
                    },
                  ),
                  //退出
                  Divider(height: 1.0, color: Colors.grey),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('logout'.tr),
                    onTap: () {
                      //删除缓存 token
                      deleteAuthentication();

                      Get.offAll(() => LoginPage());
                    },
                  )
                ],
              )),
            ),
          ],
        ),
      )
    );
  }
}
