import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/tms/pending/controller/pending_controller.dart';

class PendingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendingController>(() => PendingController());
  }
}
