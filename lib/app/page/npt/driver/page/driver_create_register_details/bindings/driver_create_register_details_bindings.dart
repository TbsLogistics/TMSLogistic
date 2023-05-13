import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register_details/controller/driver_create_register_details_controller.dart';

class DriverCreateRegisterDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverCreateRegisterDetailsController>(
        () => DriverCreateRegisterDetailsController());
  }
}
