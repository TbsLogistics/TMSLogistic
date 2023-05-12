import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create_sent/controller/letter_myself_create_sent_controller.dart';

class LetterMyselfCreateSentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LetterMyselfCreateSentController>(
        () => LetterMyselfCreateSentController());
  }
}
