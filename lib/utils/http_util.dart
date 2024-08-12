import 'package:dio/dio.dart';
import 'package:sentry_dio/sentry_dio.dart';
import '../common/constant.dart';
import '../common/global.dart';
import 'logger_util.dart';

class HttpUtil {
  static final HttpUtil _singleton = HttpUtil._init(); //单例
  static Dio dio = initDio(Constant.API_BASE_URL);

  factory HttpUtil() {
    return _singleton;
  }

  HttpUtil._init();

  // get 请求
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? params, //请求传参
        Map<String, dynamic>? headers, //请求头参数
      }) async {

    //addAll方法为两个Map合并，类型需要一致 ，且如果key相同，则会覆盖value
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      headers?.addAll(authorization);
    }

    Response response = await dio.get(
      path,
      queryParameters: params,
      options: Options(
        headers: headers,
      ),
    );
    return _handleResponse(response);
  }

  // post 请求
  Future<dynamic> post(
      String path, {
        dynamic data, //请求参数
        Map<String, dynamic>? headers, //请求头参数
      }) async {

    //addAll方法为两个Map合并，类型需要一致 ，且如果key相同，则会覆盖value
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      headers?.addAll(authorization);
    }

    Response response = await dio.post(
      path,
      data: data,
      options: Options(
        headers: headers,
      ),
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode == 200) {
      try {
        return response.data;
      } catch (e) {
        logger.e({ //Error log
          'type': '错误',
          '服务端返回的数据：': response,
        });
      }
    } else {
      logger.e({ //Error log
        'type': '错误',
        '服务端返回的数据：': response,
      });
    }
  }

  // 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers;
    String? accessToken = Global.profile.token;
    if (accessToken != null) {
      headers = {
        'Authorization': 'Bearer $accessToken',
      };
    }
    return headers;
  }
}

// 将 Dio 实例化和拦截器注册的操作放到单独的方法中，方便管理
Dio initDio(String _apiHost) {
  BaseOptions options = BaseOptions(
    baseUrl: _apiHost, //api地址
  );
  //Dio 实例化
  Dio dio = Dio(options);

  //sentry网络请求监控
  dio.addSentry();

  //添加拦截器
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      logger.i({ //Info log
        'type': '请求数据',
        '请求数据：': options.data,
        '请求地址：': options.uri.toString(),
        '请求头：': options.headers,
        '请求方式：': options.method,
      });
      return handler.next(options);
    },
    onResponse: (response, handler) {
      logger.i({ //Info log
        'type': '响应数据',
        '响应数据：': response.data,
        '响应头：': response.headers,
      });
      return handler.next(response);
    },
    onError: (e, handler) {
      // 请求出错后，关闭加载提示
      logger.e({ //Error log
        'type': '错误响应数据',
        '错误信息：': e.message,
        '错误类型：': e.type,
      });
      return handler.next(e);
    },
  ));
  return dio;
}