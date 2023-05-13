import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait/controller/wait_controller.dart';

class AwaitBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AwaitController>(() => AwaitController());
  }
}
