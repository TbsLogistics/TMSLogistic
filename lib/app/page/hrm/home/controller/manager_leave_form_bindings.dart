import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/home/controller/manager_leave_form_controller.dart';

class ManagerLeaveFormBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerLeaveFormController>(() => ManagerLeaveFormController());
  }
}
