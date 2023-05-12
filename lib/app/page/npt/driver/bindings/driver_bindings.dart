import 'package:get/get.dart';

import 'package:tbs_logistics_tms/app/page/npt/driver/controller/driver_controller.dart';

class DriverBinddings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverController>(() => DriverController());
  }
}
