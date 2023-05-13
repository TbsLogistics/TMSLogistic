import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/tms/cancel/controller/cancel_controller.dart';

class CancelPendingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CancelPendingController>(() => CancelPendingController());
  }
}
