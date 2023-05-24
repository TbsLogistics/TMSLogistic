import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/register_driver_model.dart';

class DriverCreateRegisterDetailsController extends GetxController {
  Rx<RegisterForDriverModel> detailsTicker = RegisterForDriverModel().obs;
  RxInt id = 0.obs;
  RxInt numberCont = 0.obs;
  @override
  void onInit() {
    var items = Get.arguments[0] as RegisterForDriverModel; // thong tin phieu
    var items1 = Get.arguments[1]; // id phieu
    var items2 = Get.arguments[2]; // so luong cont
    detailsTicker.value = items;
    id.value = items1;
    numberCont.value = items2;
    super.onInit();
  }
}
