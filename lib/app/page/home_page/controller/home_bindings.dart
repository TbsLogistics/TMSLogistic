import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/home_page/controller/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
