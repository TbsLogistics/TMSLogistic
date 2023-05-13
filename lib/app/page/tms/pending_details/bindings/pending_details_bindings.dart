import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/tms/pending_details/controller/pending_details_controller.dart';

class PendingDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendingDetailController>(() => PendingDetailController());
  }
}
