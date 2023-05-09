import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/tms/tms_page/controller/tms_controller.dart';

class TmsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TmsController>(() => TmsController());
  }
}
