import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//消息提示
class ToastUtil {
  static void show(String msg, {int duration = 3}) {
    Fluttertoast.showToast(
      msg: msg,
      timeInSecForIosWeb: duration,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}