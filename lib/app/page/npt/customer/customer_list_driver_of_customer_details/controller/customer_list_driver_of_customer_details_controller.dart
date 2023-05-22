import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_driver_of_customer/model/list_tracking_model.dart';

class CustomerListDriverDetailsOfCustomerController extends GetxController {
  RxBool showForm = false.obs;

  Rx<ListTrackingModel> statusDriver = ListTrackingModel().obs;

  @override
  void onInit() {
    var items = Get.arguments;
    statusDriver.value = items;
    super.onInit();
  }

  void showFormStatus() {
    showForm.value = !showForm.value;
    update();
  }
}
