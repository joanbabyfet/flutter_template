import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/app_theme.dart';
import 'theme_controller.dart';

class ThemePage extends StatelessWidget {
  ThemePage({Key? key}) : super(key: key);

  final controller = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('theme'.tr)),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            sliver: SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                //创建列表项
                return ListTile(
                  title: Text(
                    'dark_theme'.tr,
                    style: TextStyle(color: AppTheme.isDarkMode ? Colors.white : AppTheme.primaryColor(context)),
                  ),
                  trailing: Switch(
                    value: AppTheme.isDarkMode, //当前开关状态
                    onChanged: (value) { //开关状态改变时调用
                      AppTheme.changeThemeMode(value);
                    },
                  ),
                );
              }, childCount: 1),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  //创建子widget
                  return GestureDetector(
                    onTap: () {
                      //改变主题颜色
                      AppTheme.changeThemeColor(index);
                    },
                    child: Container(color: AppTheme.materialColors[index]),
                  );
                },
                childCount: AppTheme.materialColors.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //横轴元素个数
                  crossAxisCount: 3,
                  //纵轴间距
                  mainAxisSpacing: 10.0,
                  //横轴间距
                  crossAxisSpacing: 10.0,
                  //子组件宽高长度比例
                  childAspectRatio: 1.0
              )
            )
          )
        ],
      )
    );
  }
}
