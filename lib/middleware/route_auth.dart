import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../route/app_routes.dart';
import '../utils/authentication.dart';

class RouteAuthMiddleware extends GetMiddleware {
  int? priority = 0; //优先级越低越先执行

  RouteAuthMiddleware({this.priority});

  @override
  RouteSettings? redirect(String? route) {
    //Future.delayed(Duration(seconds: 1), () => Get.snackbar('提示', '请先登录APP'));

    //已否已认证
    //final controller = Get.find<AuthService>();
    //bool isAuth = controller.isAuthenticated();
    bool isAuth = isAuthenticated();
    return isAuth ? null : RouteSettings(name: AppRoutes.Login);
  }
}