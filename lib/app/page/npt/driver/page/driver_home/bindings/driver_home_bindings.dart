import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_home/controller/driver_home_controller.dart';

class DriverHomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverHomeController>(() => DriverHomeController());
  }
}
