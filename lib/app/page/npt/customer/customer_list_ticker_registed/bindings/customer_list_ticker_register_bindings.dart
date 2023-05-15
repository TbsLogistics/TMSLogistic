import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_ticker_registed/controller/customer_list_ticker_registed_controller.dart';

class CustomerListTickerRegistedBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerListTickerRegistedController>(
        () => CustomerListTickerRegistedController());
  }
}
