import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager_details_access/controller/letter_manager_details_access_controller.dart';

class LetterManagerDetailsAccessBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LetterManagerDetailsAccessController>(
        () => LetterManagerDetailsAccessController());
  }
}
