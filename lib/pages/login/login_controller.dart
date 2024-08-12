import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../api/user.dart';
import '../../common/global.dart';
import '../../route/app_routes.dart';
import '../../utils/toast_util.dart';

class LoginController extends GetxController {
  //用户名
  final usernameController = TextEditingController();
  //密码
  final passwordController = TextEditingController();
  //显示密码
  final _isShowPassword = false.obs;

  //该字段可公开访问
  get isShowPassword => _isShowPassword.value;

  @override
  void onInit() {
    super.onInit();
    debugPrint('初始化');
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('控制器被释放');
  }

  //验证通过提交数据
  Future<void> onSubmit() async {
    try {
      var userInfo = await UserAPI.login(usernameController.text, passwordController.text);
      if (userInfo.code == 0) {
        //持久化 用户信息
        Global.saveProfile(userInfo.data!);

        ToastUtil.show('login_success'.tr);
        Get.offNamed(AppRoutes.Home); //跳转到下一页并删除当前页面
      } else {
        ToastUtil.show(userInfo.msg!);
      }
    } catch (e) {
      ToastUtil.show(e.toString());
    } finally {
      passwordController.clear(); //清空密码
    }
  }

  //点击控制密码是否显示
  void showPassword() {
    _isShowPassword.value = !_isShowPassword.value;
  }
}
