import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';

class SharePerApi {
  Future<dynamic> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppConstants.KEY_ACCESS_TOKEN);
    return token;
  }

  Future<dynamic> getIdTX() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idTX = prefs.getString(AppConstants.KEY_ID_TX);
    return idTX;
  }

  Future<void> postLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(AppConstants.KEY_ACCESS_TOKEN);

    Get.offAllNamed(Routes.LOGIN_PAGE);
  }
}
