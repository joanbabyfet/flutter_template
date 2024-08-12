import 'package:get/get.dart';
import '../services/auth_service.dart';

//全局绑定控制器或服务
class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService()); //初始化认证服务
  }
}