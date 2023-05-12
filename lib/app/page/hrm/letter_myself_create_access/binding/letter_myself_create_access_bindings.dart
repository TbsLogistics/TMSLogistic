import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create_access/controller/letter_myself_create_access_controller.dart';

class LetterMyselfCreateAccess extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LetterMyselfCreateAccessController>(
        () => LetterMyselfCreateAccessController());
  }
}
