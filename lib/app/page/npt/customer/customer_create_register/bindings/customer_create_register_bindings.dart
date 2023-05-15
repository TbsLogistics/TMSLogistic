import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/controller/customer_create_register_controller.dart';

class CustomerRegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerRegisterController>(() => CustomerRegisterController());
  }
}
