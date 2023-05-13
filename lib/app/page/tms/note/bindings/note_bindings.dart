import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/tms/note/controller/note_controller.dart';

class NotePendingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotePendingController>(() => NotePendingController());
  }
}
