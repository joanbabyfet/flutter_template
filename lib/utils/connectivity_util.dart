import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ConnectivityUtil {
  static final Connectivity _connectivity = Connectivity();

  static init() async {
    final result = await _connectivity.checkConnectivity();
    updateInternetStatus(result);

    _connectivity.onConnectivityChanged.listen(updateInternetStatus);
  }

  static updateInternetStatus(List<ConnectivityResult> result) {
    if (result.first == ConnectivityResult.none) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        Get.snackbar(
          '當前狀態無網路',
          '請檢查網路連線',
          duration: Duration(days: 1),
          icon: Icon(Icons.signal_wifi_bad),
        );
      });
    } else {
      if (Get.isSnackbarOpen) {
        if (Get.isSnackbarOpen) Get.back();
      }
    }
  }
}