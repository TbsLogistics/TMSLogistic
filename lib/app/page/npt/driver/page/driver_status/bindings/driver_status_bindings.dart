import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/controller/driver_status_controller.dart';

class DriverStatusBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverStatusController>(() => DriverStatusController());
  }
}
