import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_finished/controller/driver_finished_controller.dart';

class DriverFinishedBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverFinishedController>(() => DriverFinishedController());
  }
}
