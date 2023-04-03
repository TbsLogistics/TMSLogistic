import 'package:get/get.dart';

import 'package:tbs_logistics_tms/config/routes/pages.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () => checkUserStatus());
  }

  checkUserStatus() async {
    var token = await SharePerApi().getToken();
    if (token != null) {
      Get.toNamed(Routes.TMS_PAGE);
    } else {
      Get.toNamed(Routes.LOGIN_PAGE);
    }
  }
}
