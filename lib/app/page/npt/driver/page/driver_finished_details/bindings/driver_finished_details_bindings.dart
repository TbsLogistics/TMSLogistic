import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_finished_details/controller/driver_finished_details_controller.dart';

class DriverFinishedDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverFinishedDetailsController>(
        () => DriverFinishedDetailsController());
  }
}
