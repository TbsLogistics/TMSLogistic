import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager/controller/letter_manager_controller.dart';

class LetterManagerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LetterManagerController>(() => LetterManagerController());
  }
}
