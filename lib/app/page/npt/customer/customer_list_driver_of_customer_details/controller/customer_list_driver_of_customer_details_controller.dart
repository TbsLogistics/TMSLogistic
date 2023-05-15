import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/model/list_tracking_model.dart';

class CustomerListDriverDetailsOfCustomerController extends GetxController {
  RxBool showForm = false.obs;

  Rx<ListTrackingModel> statusDriver = ListTrackingModel().obs;

  @override
  void onInit() {
    var items = Get.arguments;
    statusDriver.value = items;
    print(statusDriver.value);

    super.onInit();
  }

  void showFormStatus() {
    showForm.value = !showForm.value;
    update();
  }
}
