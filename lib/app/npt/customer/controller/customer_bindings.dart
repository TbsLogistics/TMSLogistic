import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/npt/customer/controller/customer_controller.dart';

class CustomerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(() => CustomerController());
  }
}
