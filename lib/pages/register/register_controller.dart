import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../api/user.dart';
import '../../utils/toast_util.dart';

class RegisterController extends GetxController {
  //用户名
  final usernameController = TextEditingController();
  //密码
  final passwordController = TextEditingController();
  //邮箱
  final emailController = TextEditingController();
  //昵称
  final realnameController = TextEditingController();
  //手机号
  final phoneController = TextEditingController();
  //手机号国码
  final phoneCodeController = TextEditingController();
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
      var userInfo = await UserAPI.register(usernameController.text, passwordController.text, realnameController.text, emailController.text, phoneController.text, phoneCodeController.text);
      if (userInfo.code == 0) {
        ToastUtil.show('register_success'.tr);

        Get.back(); //返回到登入页
      } else {
        ToastUtil.show(userInfo.msg!);
      }
    } catch (e) {
      ToastUtil.show(e.toString());
      Get.back(); //返回到登入页
    }
  }

  //点击控制密码是否显示
  void showPassword() {
    _isShowPassword.value = !_isShowPassword.value;
  }
}
