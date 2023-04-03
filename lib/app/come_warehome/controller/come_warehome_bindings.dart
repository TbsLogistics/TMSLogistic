import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/come_warehome/controller/come_warehome_controller.dart';

class ComeWareHomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComeWareHomeController>(() => ComeWareHomeController());
  }
}
