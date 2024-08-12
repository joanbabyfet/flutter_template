import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final controller = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();
  FocusNode blankNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('register'.tr)),
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          closeKeyboard(context);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: buildForm(context),
        ),
      ),
    );
  }

  //构建表单
  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
      autovalidateMode: AutovalidateMode.disabled,
      child: Obx(() => Column(
        children: [
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
            }
          ),
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
            }
          ),
          TextFormField(
              autofocus: false,
              controller: controller.realnameController,
              decoration: InputDecoration(
                  labelText: '昵称',
                  hintText: '请输入您的昵称',
                  hintStyle: TextStyle(fontSize: 12),
                  icon: Icon(Icons.person)),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : '昵称不能为空';
              }
          ),
          TextFormField(
              autofocus: false,
              controller: controller.emailController,
              decoration: InputDecoration(
                  labelText: '邮件',
                  hintText: '请输入您的邮件',
                  hintStyle: TextStyle(fontSize: 12),
                  icon: Icon(Icons.email)),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : '邮件不能为空';
              }
          ),
          TextFormField(
              autofocus: false,
              controller: controller.phoneController,
              decoration: InputDecoration(
                  labelText: '手机号',
                  hintText: '请输入您的手机号',
                  hintStyle: TextStyle(fontSize: 12),
                  icon: Icon(Icons.phone)),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : '手机号不能为空';
              }
          ),
          TextFormField(
              autofocus: false,
              controller: controller.phoneCodeController,
              decoration: InputDecoration(
                  labelText: '手机号国码',
                  hintText: '请输入您的手机号国码',
                  hintStyle: TextStyle(fontSize: 12),
                  icon: Icon(Icons.phone)),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : '手机号国码不能为空';
              }
          ),
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
