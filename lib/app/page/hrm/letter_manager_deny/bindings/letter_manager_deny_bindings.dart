import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager_deny/controller/letter_manager_deny_controller.dart';

class LetterManagerDenyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LetterManagerDenyController>(
        () => LetterManagerDenyController());
  }
}
