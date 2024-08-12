import '../entity/ad.dart';
import '../utils/http_util.dart';

class AdAPI {
  static Future<Ad> adList(int limit) async {
    Map<String, dynamic> params = {
      'limit': limit,
    };
    Map<String, dynamic> headers = {};
    //res这里返回Map<String, dynamic>
    var res = await HttpUtil().get('/ad', params: params, headers: headers);
    return Ad.fromJson(res);
  }
}