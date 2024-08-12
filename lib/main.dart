import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/common/app_binding.dart';
import 'package:flutter_template/route/app_pages.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'common/app_theme.dart';
import 'common/constant.dart';
import 'common/global.dart';
import 'lang/translation_service.dart';

Future<void> main() async {
  await Global.init(); //全局配置
  //await initServices(); //用于启动App之前进行初始化工作, 在runApp之前生效

  //sentry客户端, 全局异常捕捉
  await SentryFlutter.init((options) {
    options.dsn = Constant.SENTRY_DSN;
    options.environment = Constant.APP_ENV;
    options.tracesSampleRate = 1.0;
    options.profilesSampleRate = 1.0;
    //网络请求监控
    options.captureFailedRequests = true;
    options.maxRequestBodySize = MaxRequestBodySize.always;
    options.maxResponseBodySize = MaxResponseBodySize.always;
  }, appRunner: () => runApp(DefaultAssetBundle(bundle: SentryAssetBundle(), child: const MyApp())) //监控AssetBundle
  );
}

//单例模式, 用于全局业务逻辑、持久化数据、全局状态, 不会随页面或widget销毁而销毁
// Future<void> initServices() async {
//   debugPrint('初始化服务');
//   await Get.putAsync(() async => AuthService());
//   debugPrint('所有服务启动');
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //在 MaterialApp 组件外层包裹1层 ScreenUtilInit组件, 否则会报错
    return ScreenUtilInit( //尺寸大小根据屏幕自适应
      designSize: const Size(375, 812), //设计稿宽高px
      minTextAdapt: true, //是否根据宽高中最小值适配文字
      splitScreenMode: true, //支持分屏尺寸
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AppBinding(), //初始绑定类
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.pages,
          unknownRoute: AppPages.unknownRoute,
          debugShowCheckedModeBanner: false, //干掉右上角Debug标签
          locale: TranslationService.locale, //当前系统语言
          fallbackLocale: TranslationService.fallbackLocale, //找不到对应字典时默认为英文
          translations: TranslationService(), //字典列表
          theme: AppTheme.theme(), //明亮模式
          darkTheme: AppTheme.darkTheme(), //暗黑模式
          navigatorObservers: [ //通过sentry监控页面路由Navigation
            SentryNavigatorObserver()
          ],
          builder: EasyLoading.init(), //初始化加载中动画
        );
      }
    );
  }
}
