import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/tms/finished_details/controller/finished_detail_controller.dart';

class FinishedDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinishedDetailController>(() => FinishedDetailController());
  }
}
