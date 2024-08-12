import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../route/app_routes.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  FocusNode blankNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    //防止用户误触返回键退出
    return PopScope(
      canPop: false, // 允许返回
      child: Scaffold(
        appBar: AppBar(
          title: Text('login'.tr),
          actions: [
            TextButton(
              child: Text('register'.tr),
              onPressed: () {
                Get.toNamed(AppRoutes.Register);
              },
            )
          ],
        ),
        //创建手势检测器实例
        body: GestureDetector(
          onTap: () {
            // 点击空白页面关闭键盘
            closeKeyboard(context);
          },
          child: SingleChildScrollView(
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: buildForm(context),
          ),
        ),
      )
    );
  }

  //构建表单
  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
      autovalidateMode: AutovalidateMode.disabled, //自动验证表单输入
      child: Obx(() => Column(
        children: [
          Center(
              heightFactor: 1.5,
              child: FlutterLogo(
                size: 64,
              )),
          TextFormField(
              autofocus: false,
              controller: controller.usernameController,
              decoration: InputDecoration(
                  labelText: 'login_name'.tr,
                  hintText: 'login_name_hint'.tr,
                  hintStyle: TextStyle(fontSize: 12),
                  icon: Icon(Icons.person)),
              //校验用户名
              validator: (v) {
                return v!.trim().isNotEmpty
                    ? null
                    : 'login_name_error'.tr;
              }),
          TextFormField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                  labelText: 'password'.tr,
                  hintText: 'password_hint'.tr,
                  hintStyle: TextStyle(fontSize: 12),
                  icon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: Icon(
                        controller.isShowPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: controller.showPassword
                  )
              ),
              obscureText: !controller.isShowPassword,
              //校验密码
              validator: (v) {
                return v!.trim().length >= 6
                    ? null
                    : 'password_error'.tr;
              }),
          // 登录按钮
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: [
                Expanded(child: Builder(builder: (context) {
                  return ElevatedButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.all(15.0)),
                    child: Text('login'.tr),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //关闭键盘
                        closeKeyboard(context);
                        //显示加载提示, 加载中...
                        EasyLoading.show();
                        Future.delayed(Duration(seconds: 2), () {
                          EasyLoading.dismiss(); //2秒后隐藏加载提示
                        });

                        controller.onSubmit();
                      }
                    },
                  );
                })),
              ],
            ),
          )
        ],
      )),
    );
  }

  //关闭键盘
  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(blankNode);
  }
}
