import 'package:flutter_dotenv/flutter_dotenv.dart';

// 全局变量
class Constant {
  static String APP_ENV = dotenv.env['APP_ENV'].toString();
  static String API_BASE_URL = dotenv.env['API_BASE_URL'].toString();
  static String SENTRY_DSN = dotenv.env['SENTRY_DSN'].toString();
  static String GOOGLE_API_KEY = dotenv.env['GOOGLE_API_KEY'].toString();
  static String SOCKET_URL = dotenv.env['SOCKET_URL'].toString();
  static String DB_NAME = dotenv.env['DB_NAME'].toString();
  static String UPDATE_URL = dotenv.env['UPDATE_URL'].toString();
}