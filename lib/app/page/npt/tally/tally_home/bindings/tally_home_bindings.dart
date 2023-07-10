import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/tally/tally_home/controller/tally_home_controller.dart';

class TallyHomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TallyHomeController>(() => TallyHomeController());
  }
}
