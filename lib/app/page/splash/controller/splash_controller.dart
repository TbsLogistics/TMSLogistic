import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () => checkUserStatus());
  }

  checkUserStatus() async {
    var tokenTMS = await SharePerApi().getTokenTMS();
    var tokenNPT = await SharePerApi().getTokenNPT();
    var tokenHRM = await SharePerApi().getTokenHRM();
    if (tokenTMS != null || tokenNPT != null || tokenHRM != null) {
      Get.toNamed(Routes.HOME_PAGE);
    } else {
      Get.toNamed(Routes.LOGIN_PAGE);
    }
  }
}
