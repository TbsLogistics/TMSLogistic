// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbs_logistics_tms/app/page/login/model/user_npt_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/tms_page/model/user_model.dart';

import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';

class HomeController extends GetxController {
  Rx<UserModel> user = UserModel().obs;
  Rx<UserNptModel> user_npt = UserNptModel().obs;

  Rx<AppUpdateInfo>? updateInfo;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool _flexibleUpdateAvailable = false;

  RxString tokenTms = "".obs;
  RxString tokenNpt = "".obs;
  RxString tokenHrm = "".obs;

  @override
  void onInit() {
    _scaffoldKey;
    getUser();
    super.onInit();
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      updateInfo!.value = info;
      print("info : $info");
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  void getUser() async {
    var tokenTMS = await SharePerApi().getTokenTMS();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (tokenTMS != null) {
      tokenTms.value = tokenTMS;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenTMS);
      user.value = UserModel.fromJson(decodedToken);
      getDialogMessage("Bạn có thể sử dụng tính năng TMS");
    }
    var tokenNPT = await SharePerApi().getTokenNPT();
    if (tokenNPT != null) {
      tokenNpt.value = tokenNPT;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenNPT);

      user_npt.value = UserNptModel.fromJson(decodedToken);
      getDialogMessage("Bạn có thể sử dụng tính năng Đăng tài");
    }
    var tokenHRM = await SharePerApi().getTokenHRM();
    if (tokenHRM != null) {
      tokenHrm.value = tokenHRM;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenHRM);
      user.value = UserModel.fromJson(decodedToken);
      getDialogMessage("Bạn có thể sử dụng tính năng Đăng kí nghỉ phép");
    }
  }

  void getDialogMessage(String messageText) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "Thông báo",
      titleStyle: const TextStyle(
          color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
      content: SizedBox(
        height: 60,
        width: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    messageText,
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      confirm: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "Xác nhận",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
