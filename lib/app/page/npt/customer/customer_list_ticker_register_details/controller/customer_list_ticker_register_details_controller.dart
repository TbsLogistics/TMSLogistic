import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_ticker_registed/model/list_registed_of_customer_model.dart';

class CustomerListTickerRegisterDetailsController extends GetxController {
  Rx<ListRegisterDriverOfCustomerModel> listTracking =
      ListRegisterDriverOfCustomerModel().obs;

  @override
  void onInit() {
    var items = Get.arguments as ListRegisterDriverOfCustomerModel;
    listTracking.value = items;
    super.onInit();
  }
}
