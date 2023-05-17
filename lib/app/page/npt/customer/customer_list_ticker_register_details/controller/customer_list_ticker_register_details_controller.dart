import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_driver_of_customer/model/list_tracking_model.dart';

class CustomerListTickerRegisterDetailsController extends GetxController {
  Rx<ListTrackingModel> listTracking = ListTrackingModel().obs;

  @override
  void onInit() {
    var items = Get.arguments as ListTrackingModel;
    listTracking.value = items;
    super.onInit();
  }
}
