import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/controller/sercurity_controller.dart';

class SercurityBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SercurityController>(() => SercurityController());
  }
}
