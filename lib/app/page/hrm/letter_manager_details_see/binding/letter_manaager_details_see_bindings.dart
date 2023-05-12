import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager_details_see/controller/letter_manager_details_see_controler.dart';

class LetterManagerDetailsSeeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LetterManagerDetailsSeeController>(
        () => LetterManagerDetailsSeeController());
  }
}
