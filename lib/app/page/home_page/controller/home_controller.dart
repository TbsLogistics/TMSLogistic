// ignore_for_file: unused_local_variable, non_constant_identifier_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:in_app_update/in_app_update.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/widget/button_success.dart';

import 'package:tbs_logistics_tms/app/page/home_page/model/user_hrm_model.dart';
import 'package:tbs_logistics_tms/app/page/login/model/user_npt_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/tms_page/model/user_model.dart';

import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';

class HomeController extends GetxController {
  var dio = Dio();
  Rx<UserModel> user = UserModel().obs;
  Rx<UserNptModel> user_npt = UserNptModel().obs;
  Rx<UserHrmModel> user_hrm = UserHrmModel().obs;

  String release = "";

  Rx<AppUpdateInfo>? updateInfo;

  RxString tokenTms = "".obs;
  RxString tokenNpt = "".obs;
  RxString tokenHrm = "".obs;

  @override
  void onInit() async {
    // getCurrentLocation();
    getUser();

    super.onInit();
    // final newVersion = NewVersionPlus(
    //   // iOSId: 'your_ios_app_id',
    //   androidId: 'com.tbslogistic.tms.name',
    // );

    // newVersion.showAlertIfNecessary(context: Get.context!);

    // final status = await newVersion.getVersionStatus();

    // if (status != null) {
    //   // debugPrint(status.releaseNotes);
    //   // debugPrint(status.appStoreLink);
    //   // debugPrint(status.localVersion);
    //   // debugPrint(status.storeVersion);
    //   // debugPrint(status.canUpdate.toString());
    //   // Xét Phiên Bản Trên Cửa Hàng Lớn Hơn Phiên Bản Ở Thiết Bị Thì Chạy Popup Cập Nhật
    //   if (status.canUpdate) {
    //     getSnack(
    //         messageText:
    //             "Có phiên mới, vui lòng cập nhật phiên bản mới để hoàn thiện tính năng !");
    //   }
    // }
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return getSnack(messageText: 'Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return getSnack(messageText: 'Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return getSnack(
            messageText:
                'Location permissions are permanently denied, we cannot request permissions.');
      }
    }
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    var lat = position.latitude;
    var long = position.longitude;
    var latLate = position.latitude;
    var longLate = position.longitude;
    double distance = Geolocator.distanceBetween(
      lat,
      long,
      latLate,
      longLate,
    );

    // passing this to latitude and longitude strings
  }

  void getUser() async {
    var tokenTMS = await SharePerApi().getTokenTMS();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (tokenTMS != null) {
      tokenTms.value = tokenTMS;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenTMS);
      user.value = UserModel.fromJson(decodedToken);
      var userid_hrm =
          prefs.setString(AppConstants.KEY_USER_TMS, "${user.value.userName}");
      // getDialogMessage("Bạn có thể sử dụng tính năng TMS");
      diaLogMessage(size: Get.size);
    }
    var tokenNPT = await SharePerApi().getTokenNPT();
    if (tokenNPT != null) {
      tokenNpt.value = tokenNPT;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenNPT);

      user_npt.value = UserNptModel.fromJson(decodedToken);
      // getDialogMessage("Bạn có thể sử dụng tính năng Đăng tài");
    }
    var tokenHRM = await SharePerApi().getTokenHRM();
    if (tokenHRM != null) {
      tokenHrm.value = tokenHRM;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenHRM);
      user_hrm.value = UserHrmModel.fromJson(decodedToken);
      var userid_hrm = prefs.setString(
          AppConstants.KEY_USER_HRM, "${user_hrm.value.username}");

      // getDialogMessage("Bạn có thể sử dụng tính năng Đăng kí nghỉ phép");
    }
  }

  void diaLogMessage({required Size size}) {
    Get.defaultDialog(
      title: "Thông báo",
      titleStyle: const TextStyle(
        color: Colors.red,
        fontSize: 20,
      ),
      barrierDismissible: false,
      content: Column(
        children: [
          const SizedBox(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Ứng dụng này thu thập dữ liệu vị trí để để lấy vị trí của bạn, ngay cả khi đã đóng hoặc không sử dụng !",
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 300,
            width: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ggmap.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      confirm: ButtonComment(
          text: "Xác nhận",
          onPressed: () {
            getCurrentLocation();
            Get.back();
          }),
      cancel: ButtonFinal(
        text: "Hủy",
        onPressed: () {
          Get.back();
        },
      ),
    );
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

  void getSnack({required String messageText}) {
    Get.snackbar(
      "",
      "",
      titleText: const Text(
        "Thông báo",
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        messageText,
        style: const TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }
}
