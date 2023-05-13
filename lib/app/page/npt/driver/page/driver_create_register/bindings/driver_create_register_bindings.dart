import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/controller/driver_create_register_controller.dart';

class DriverCreateRegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverCreateRegisterController>(
        () => DriverCreateRegisterController());
  }
}
