import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/common/storage.dart';
import '../utils/storage_util.dart';
import 'package:get/get.dart';

class AppTheme {
  static final List<MaterialColor> materialColors = [
    Colors.blue,
    Colors.lightBlue,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.grey,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
    Colors.lime
  ];
  static bool isDarkMode = false; //是否暗黑
  static int themeIndex = 0; //颜色, 默认蓝色 Colors.blue
  static init() async {
    themeIndex = StorageUtil.containsKey(STORAGE_THEME_COLOR_KEY) ? StorageUtil.get(STORAGE_THEME_COLOR_KEY) : 0;
    //初始化当前主题模式 明亮或暗黑
    isDarkMode = StorageUtil.containsKey(STORAGE_IS_DARK_KEY) ? StorageUtil.get(STORAGE_IS_DARK_KEY) : false;
    Get.changeThemeMode(AppTheme.isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
  static Color currentColor() => materialColors[themeIndex];
  static Color primaryColor(BuildContext context) => Theme.of(context).primaryColor;
  static Color darkBg = Colors.black;

  //改变主题颜色
  static changeThemeColor(int index){
    if(themeIndex != index){
      themeIndex = index;
      Get.changeTheme(isDarkMode ? darkTheme() : theme());
      //持久化主题颜色
      StorageUtil.set(STORAGE_THEME_COLOR_KEY, themeIndex);
      //切换主题后无法立即生效, 要设罝延迟
      Future.delayed(const Duration(milliseconds: 250), () {
        Get.forceAppUpdate(); //强制更新app状态
      });
    }
  }

  //改变明亮或暗黑
  static changeThemeMode(bool isDark){
    isDarkMode = isDark;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    //持久化主题颜色
    StorageUtil.set(STORAGE_IS_DARK_KEY, isDark);
    //切换主题后无法立即生效, 要设罝延迟
    Future.delayed(const Duration(milliseconds: 250), () {
      Get.forceAppUpdate(); //强制更新app状态
    });
  }

  static ThemeData theme() {
    var color = currentColor();

    //从上层 Theme 扩展, 可不用从头定制一套样式
    return ThemeData.light().copyWith(
      primaryColor: color, //主色
      appBarTheme: AppBarTheme(
        elevation: 0, //阴影
        centerTitle: true,
      ),
    );
  }

  static ThemeData darkTheme() {
    var color = currentColor();

    //从上层 Theme 扩展, 可不用从头定制一套样式
    return ThemeData.dark().copyWith(
      primaryColor: color, //主色
      scaffoldBackgroundColor: darkBg,
      appBarTheme: AppBarTheme(
        backgroundColor: darkBg,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}