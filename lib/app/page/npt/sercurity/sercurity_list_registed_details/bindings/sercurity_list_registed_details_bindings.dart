import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_list_registed_details/controller/sercurity_list_registed_details_controller.dart';

class SercurityListRegistedDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SercurityListRegistedDetailController>(
        () => SercurityListRegistedDetailController());
  }
}
