import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/tms/finished/controller/finished_controller.dart';

class FinishedBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinishedController>(() => FinishedController());
  }
}
