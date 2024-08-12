import '../entity/user.dart';
import '../utils/http_util.dart';

//统一管理接口
class UserAPI {
  static Future<User> login(String username, String password) async {
    Map<String, dynamic> params = {
      'username': username,
      'password': password,
      //'code': '',
      //'key': '',
    };
    Map<String, dynamic> headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    //res这里返回Map<String, dynamic>
    var res = await HttpUtil().post('/login', data: params, headers: headers);
    return User.fromJson(res);
  }

  static Future<User> register(String username, String password, String realname, String email, String phone, String phone_code) async {
    Map<String, dynamic> params = {
      'username': username,
      'password': password,
      'realname': realname,
      'email': email,
      'phone': phone,
      'phone_code': phone_code,
    };
    Map<String, dynamic> headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    //res这里返回Map<String, dynamic>
    var res = await HttpUtil().post('/register', data: params, headers: headers);
    return User.fromJson(res);
  }
}