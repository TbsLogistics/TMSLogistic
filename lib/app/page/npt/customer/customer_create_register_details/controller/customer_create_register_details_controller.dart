import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_register_for_driver_model.dart';

class CustomerRegisterDetailsController extends GetxController {
  Rx<CustomerRegisterForDriverModel> detailsTicker =
      CustomerRegisterForDriverModel().obs;

  @override
  void onInit() {
    var items = Get.arguments as CustomerRegisterForDriverModel;
    detailsTicker.value = items;
    super.onInit();
  }
}
