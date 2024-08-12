import 'package:get/get.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //只有使用时才会实例化, 例执行以下代码 Get.find();
    Get.lazyPut(() => HomeController());
  }
}
