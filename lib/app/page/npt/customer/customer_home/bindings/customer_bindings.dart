import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_home/controller/customer_controller.dart';

class CustomerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(() => CustomerController());
  }
}
