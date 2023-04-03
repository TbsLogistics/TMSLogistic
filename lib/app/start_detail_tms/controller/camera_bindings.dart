import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/controller/camera_controller.dart';

class CameraBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraController>(() => CameraController());
  }
}
