import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/login/controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
