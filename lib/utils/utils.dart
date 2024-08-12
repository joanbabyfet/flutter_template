import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_template/utils/toast_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'logger_util.dart';
import 'package:get/get.dart';

//常用工具类
class Utils {
  static Utils? _instance;

  Utils._internal() {
    _instance = this;
  }

  factory Utils() => _instance ?? Utils._internal();

  //获取网路状态
  static Future<bool> getInternetStatus() async {
    //单次请求检查
    final Connectivity connectivity = Connectivity();
    var result = await connectivity.checkConnectivity();
    if (result.first == ConnectivityResult.mobile) {
      return true;
    } else if (result.first == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  //打开浏览器
  static void launch(String url) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      logger.e(e);
      ToastUtil.show('Could not launch $url');
    }
  }

  //获取当前日期
  static String formatDateTime(DateTime dateTime) => formatDate(dateTime, [yyyy, '-', mm, '-', dd]);

  //获取当前时间戳(毫秒)
  static String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  //去除HTML标签
  static String stripHtml(String text) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );
    return text.replaceAll(exp, '');
  }

  //跳转到web
  static void goWeb(String url, String title) {
    Get.toNamed('/web?url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent(title)}');
  }
}