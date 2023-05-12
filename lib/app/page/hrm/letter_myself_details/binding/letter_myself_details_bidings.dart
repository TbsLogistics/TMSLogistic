import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_details/controller/letter_myself_details_controller.dart';

class LetterMyselfDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LetterMyselfDetailsController());
  }
}
