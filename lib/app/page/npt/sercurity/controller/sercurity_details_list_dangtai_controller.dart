import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/model/list_dangtai_model.dart';

class SercurityDetailsListDangTaiController extends GetxController {
  Rx<ListDangTaiModel> items = ListDangTaiModel().obs;
  @override
  void onInit() {
    var item = Get.arguments;
    items.value = item;
    super.onInit();
  }
}
