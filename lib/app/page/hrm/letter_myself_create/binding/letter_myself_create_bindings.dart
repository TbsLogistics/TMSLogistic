import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create/controller/letter_myself_create_controller.dart';

class LetterMyselfCreateBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LetterMyselfCreateController>(
        () => LetterMyselfCreateController());
  }
}
