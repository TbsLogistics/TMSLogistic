import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/tms/change_password/model/change_password_model.dart';

class ChangePassController extends GetxController {
  // TextEditingController username = TextEditingController();
  TextEditingController passwordNew = TextEditingController();
  TextEditingController passwordOld = TextEditingController();
  TextEditingController rePasswordNew = TextEditingController();

  RxString userName = "".obs;

  RxBool isLoadLogin = false.obs;
  final changePassKey = GlobalKey<FormState>();
  RxBool obcureText = false.obs;

  @override
  void onInit() {
    var user = Get.arguments;
    userName.value = user;
    changePassKey;
    super.onInit();
  }

  void updateObcureText() {
    obcureText.value = !obcureText.value;
    update();
  }

  void changePassword({
    required String oldPassword,
    required String newPassword,
    required String reNewPassword,
  }) async {
    Response response;
    var dio = Dio();
    var changePassword = ChangePasswordModel(
      oldPassword: oldPassword,
      newPassword: newPassword,
      reNewPassword: reNewPassword,
    );
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var jsonData = changePassword.toJson();
    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/ChangePassword?username=${userName.value}";
    try {
      response = await dio.post(url,
          data: jsonData, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = response.data;
        print(data);
        Get.back();
        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: Text(
            "${data["message"]}!",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
          snackPosition: SnackPosition.TOP,
        );
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        Get.snackbar(
          "Thông báo",
          "Nhập thiếu tài khoản hoặc mật khẩu !",
          backgroundColor: Colors.white,
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: Text(
            "${e.response!.data["message"]} !",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      } else if (e.response!.statusCode == 500) {
        Get.snackbar(
          "Thông báo",
          "Nhập thiếu tài khoản hoặc mật khẩu !",
          backgroundColor: Colors.white,
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: const Text(
            "Lỗi máy chủ vui lòng xem lại mạng !",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    } finally {
      isLoadLogin(true);
    }
  }
}
