import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait_details/controller/wait_details_controller.dart';

class AwaitDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AwaitDetailsController>(() => AwaitDetailsController());
  }
}
