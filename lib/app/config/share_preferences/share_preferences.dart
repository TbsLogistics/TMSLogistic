import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';

class SharePerApi {
  Future<dynamic> getTokenTMS() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppConstants.KEY_ACCESS_TOKEN_TMS);
    return token;
  }

  Future<dynamic> getTokenNPT() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppConstants.KEY_ACCESS_TOKEN_NPT);
    return token;
  }

  Future<dynamic> getTokenHRM() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppConstants.KEY_ACCESS_TOKEN_HRM);
    return token;
  }

  Future<dynamic> getIdTX() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idTX = prefs.getString(AppConstants.KEY_ID_TX);
    return idTX;
  }

  // NPT
  Future<String> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var role = prefs.getString(AppConstants.KEY_ROLE);
    return role.toString();
  }

  Future<String> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idUser = prefs.getString(AppConstants.KEY_ID_USER);
    return idUser.toString();
  }

  Future<String> getIdKH() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idKH = prefs.getString(AppConstants.KEY_ID_KH);
    return idKH.toString();
  }

  Future<String> getIdKHforTX() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idKHforTX = prefs.getString(AppConstants.KEY_ID_KH_OF_DRIVER);
    return idKHforTX.toString();
  }

  Future<String> getIdBophan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idBoPhan = prefs.getString(AppConstants.KEY_ID_MABOPHAN);
    return idBoPhan.toString();
  }

  Future<String> getidNV() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var maNv = prefs.getString(AppConstants.KEY_ID_MANV);
    return maNv.toString();
  }

  Future<String> getUserNpt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userNpt = prefs.getString(AppConstants.KEY_USER_NPT);
    return userNpt.toString();
  }

  //HRM

  Future<void> postLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(AppConstants.KEY_ACCESS_TOKEN_TMS);
    pref.remove(AppConstants.KEY_ACCESS_TOKEN_NPT);
    pref.remove(AppConstants.KEY_ACCESS_TOKEN_HRM);

    Get.offAllNamed(Routes.LOGIN_PAGE);
  }
}
