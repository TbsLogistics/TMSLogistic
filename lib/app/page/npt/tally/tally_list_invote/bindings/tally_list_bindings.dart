import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/tally/tally_list_invote/controller/tally_list_controller.dart';

class TallyListBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TallyListController>(() => TallyListController());
  }
}
