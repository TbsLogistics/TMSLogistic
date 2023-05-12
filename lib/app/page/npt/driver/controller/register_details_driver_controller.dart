import 'package:get/get.dart';

import 'package:tbs_logistics_tms/app/page/npt/driver/model/register_driver_model.dart';

class RegisterDetailsDriverController extends GetxController {
  Rx<RegisterForDriverModel> detailsTicker = RegisterForDriverModel().obs;
  @override
  void onInit() {
    var items = Get.arguments as RegisterForDriverModel;
    detailsTicker.value = items;
    super.onInit();
  }
}
