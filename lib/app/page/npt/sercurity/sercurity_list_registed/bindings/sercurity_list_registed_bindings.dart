import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_list_registed/controller/sercurity_list_registed_controller.dart';

class SercurityListRegistedBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SercurityListRegistedController>(
        () => SercurityListRegistedController());
  }
}
