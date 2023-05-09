import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/npt/driver/view/status/controller/list_status_uninished_controller.dart';

class ListStatusUnfinishedBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListStatusUnfinishedController>(
        () => ListStatusUnfinishedController());
  }
}
