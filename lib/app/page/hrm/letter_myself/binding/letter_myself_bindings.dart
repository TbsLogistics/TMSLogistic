import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself/controller/letter_myself_controller.dart';

class LetterMySelfBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LetterMyselfController>(() => LetterMyselfController());
  }
}
