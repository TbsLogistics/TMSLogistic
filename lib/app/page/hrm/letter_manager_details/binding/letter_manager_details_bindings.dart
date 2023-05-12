import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager_details/controller/letter_manager_details_controller.dart';

class LetterManagerDrtailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LetterManagerDetailsController>(
        () => LetterManagerDetailsController());
  }
}
