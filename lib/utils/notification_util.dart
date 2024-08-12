import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//全局变量
var notificationUtil = NotificationUtil();

class NotificationUtil {
  final FlutterLocalNotificationsPlugin np = FlutterLocalNotificationsPlugin();

  //初始化
  Future<void> init() async {
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = const DarwinInitializationSettings();

    await np.initialize(InitializationSettings(android: android, iOS: ios),
        onDidReceiveNotificationResponse: onSelectNotification);
  }

  //点击通知回调事件
  void onSelectNotification(NotificationResponse notificationResponse) async {
    var payload = json.decode(notificationResponse.payload!);
    if (payload != null) {
      debugPrint('notification payload: $payload');
      // todo 这里根据自己的业务处理
    }
  }

  // 发送通知
  void send(String title, String body, {int? notificationId, String? params}) {
    // 构建描述
    var androidDetails = const AndroidNotificationDetails(
      'channelId', //区分不同渠道的标识
      'channelName', //channelName渠道描述不要随意填写，会显示在手机设置，本app 、通知列表中，规范写法根据业务：比如： 重要通知，一般通知、或者，交易通知、消息通知、等
      importance: Importance.max, //通知的级别
      priority: Priority.high,
      // icon: '', //可以单独设置每次发送通知的图标
      // progress: 19, //显示进度条 3个参数必须同时设置
      // maxProgress: 100,
      // showProgress: true,
    );
    //ios配置选项相对较少
    var iosDetails = const DarwinNotificationDetails();
    var details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    // 显示通知, 第一个参数是id, id如果一致则会覆盖之前的通知, String? payload, 点击时可以拿到的参数
    np.show(notificationId ?? DateTime.now().millisecondsSinceEpoch >> 10, //Shift right 右移
        title, body, details,
        payload: params);
  }

  //清除所有通知
  void cleanNotification() {
    np.cancelAll();
  }

  //清除指定id的通知
  // `tag`参数指定Android标签。 如果提供，那么同时匹配 id 和 tag 的通知将会被取消。 `tag` 对其他平台没有影响。
  void cancelNotification(int id, {String? tag}) {
    np.cancel(id, tag: tag);
  }
}