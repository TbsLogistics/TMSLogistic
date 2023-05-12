import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/tms/start_detail_tms/controller/start_detail_tms_controller.dart';

class StartDetailTmsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartDetailTmsController>(() => StartDetailTmsController());
  }
}
