import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/tally/tally_input_status_cont_invote/controller/tally_input_status_controller.dart';

class TallyInputStatusBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TallyInputStatusController>(() => TallyInputStatusController());
  }
}
