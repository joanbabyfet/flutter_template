import 'package:get/get.dart';
import '../common/storage.dart';
import '../utils/storage_util.dart';

class AuthService extends GetxService {
  // 检查是否有 token
  bool isAuthenticated() {
    var profileJSON = StorageUtil.get(STORAGE_USER_PROFILE_KEY);
    return profileJSON != null ? true : false;
  }
}