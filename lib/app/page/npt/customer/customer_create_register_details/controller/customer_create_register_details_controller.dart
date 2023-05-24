import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_register_for_driver_model.dart';

class CustomerRegisterDetailsController extends GetxController {
  Rx<CustomerRegisterForDriverModel> detailsTicker =
      CustomerRegisterForDriverModel().obs;
  RxInt id = 0.obs;

  @override
  void onInit() {
    var items = Get.arguments[0] as CustomerRegisterForDriverModel;
    var items1 = Get.arguments[1];
    detailsTicker.value = items;
    id.value = items1;
    super.onInit();
  }
}
