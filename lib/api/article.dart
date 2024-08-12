import '../entity/article.dart';
import '../utils/http_util.dart';

class ArticleAPI {
  static Future<Article> articlePageList(int page, int pageSize) async {
    Map<String, dynamic> params = {
      'page': page,
      'page_size': pageSize,
    };
    Map<String, dynamic> headers = {};
    //res这里返回Map<String, dynamic>
    var res = await HttpUtil().get('/article', params: params, headers: headers);
    return Article.fromJson(res);
  }
}