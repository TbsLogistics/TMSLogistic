import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/model/driver_list_ticker_model.dart';

class SercurityDetailsListDangTaiController extends GetxController {
  Rx<DriverListTickerModel> items = DriverListTickerModel().obs;
  @override
  void onInit() {
    var item = Get.arguments as DriverListTickerModel;
    items.value = item;
    super.onInit();
  }
}
