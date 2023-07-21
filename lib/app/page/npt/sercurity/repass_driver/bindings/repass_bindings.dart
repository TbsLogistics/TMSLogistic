import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/repass_driver/controller/repass_controller.dart';

class SercurityRePassBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SercurityRePassController>(() => SercurityRePassController());
  }
}
