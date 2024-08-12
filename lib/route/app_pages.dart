import 'package:get/get.dart';
import '../middleware/route_auth.dart';
import '../pages/about/about_view.dart';
import '../pages/home/home_binding.dart';
import '../pages/home/home_view.dart';
import '../pages/language/language_view.dart';
import '../pages/login/login_view.dart';
import '../pages/not_found/not_found_view.dart';
import '../pages/register/register_view.dart';
import '../pages/setting/setting_view.dart';
import '../pages/sponsor/sponsor_view.dart';
import '../pages/theme/theme_binding.dart';
import '../pages/theme/theme_view.dart';
import '../pages/web/web_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.Home;

  // 白名单
  static final pages = [
    GetPage(
      name: AppRoutes.Home,
      page: () => HomePage(),
      binding: HomeBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 1), //路由认证中间件, 优先级越低越先执行
      ]
    ),
    GetPage(
      name: AppRoutes.Sponsor,
      page: () => SponsorPage(),
    ),
    GetPage(
      name: AppRoutes.Setting,
      page: () => SettingPage(),
    ),
    GetPage(
      name: AppRoutes.About,
      page: () => AboutPage(),
    ),
    GetPage(
      name: AppRoutes.Login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.Register,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: AppRoutes.Web,
      page: () => WebPage(),
    ),
    GetPage(
      name: AppRoutes.Language,
      page: () => LanguagePage(),
    ),
    GetPage(
      name: AppRoutes.Theme,
      page: () => ThemePage(),
      binding: ThemeBinding(),
    ),
  ];

  static final unknownRoute = GetPage(
      name: AppRoutes.NotFound,
      page: () => NotFoundPage()
  );
}