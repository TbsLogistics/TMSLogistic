import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status_details/controller/driver_status_details_controller.dart';

class DriverStatusDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverStatusDetailsController>(
        () => DriverStatusDetailsController());
  }
}
