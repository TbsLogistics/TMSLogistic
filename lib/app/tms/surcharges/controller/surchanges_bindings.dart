import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/tms/surcharges/controller/surchanges_controller.dart';

class SurChangesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurChangesController>(() => SurChangesController());
  }
}
