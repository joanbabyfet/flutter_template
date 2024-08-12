import 'package:flutter_template/route/app_routes.dart';
import 'package:flutter_template/utils/storage_util.dart';
import '../common/global.dart';
import '../common/storage.dart';
import '../entity/user.dart';
import 'package:get/get.dart';

// 检查是否有 token
bool isAuthenticated() {
  var profileJSON = StorageUtil.get(STORAGE_USER_PROFILE_KEY);
  return profileJSON != null ? true : false;
}

// 删除缓存 token
Future deleteAuthentication() async {
  await StorageUtil.remove(STORAGE_USER_PROFILE_KEY);

  //清空全局用户配置
  Global.profile = UserProfile();
}

// 重新登录
void deleteTokenAndReLogin() async {
  await deleteAuthentication();
  //Get.offAll(LoginPage());
  Get.offAndToNamed(AppRoutes.Login); //跳到的下个页面会替换上个页面
}