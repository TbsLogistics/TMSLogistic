import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/home_page/model/change_password_hrm_model.dart';
import 'package:tbs_logistics_tms/app/page/home_page/model/change_password_npt_model.dart';
import 'package:tbs_logistics_tms/app/page/home_page/model/change_password_tms_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/change_password/model/change_password_model.dart';

class ChangePassController extends GetxController {
  var dio = Dio();
  // TextEditingController username = TextEditingController();
  TextEditingController passwordNew = TextEditingController();
  TextEditingController passwordOld = TextEditingController();
  TextEditingController rePasswordNew = TextEditingController();

  RxString userName = "".obs;

  RxBool isLoadLogin = false.obs;
  final changePassKey = GlobalKey<FormState>();
  RxBool obcureText = true.obs;

  @override
  void onInit() {
    changePassKey;
    super.onInit();
  }

  void updateObcureText() {
    obcureText.value = !obcureText.value;
    update();
  }

  void changePassHrm({
    required String oldPassword,
    required String newPassword,
    required String confirmPass,
  }) async {
    Response response;

    var token = await SharePerApi().getTokenHRM();

    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var user_hrm = await SharePerApi().getIdUserHRM();

    var passWord = ChangePassHrmModel(
      currentPassword: oldPassword,
      newPassword: newPassword,
      confirmPass: confirmPass,
    );
    var jsonData = passWord.toJson();
    var url = "${AppConstants.urlBaseHrm}/changePass";

    try {
      response = await dio.post(
        url,
        data: jsonData,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var data = response.data;

        if (data["rCode"] == 1) {
          getSnack(message: data["rMsg"]);
        } else {
          getSnack(message: data["rMsg"]);
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
      } else if (e.response!.statusCode == 404) {
      } else if (e.response!.statusCode == 500) {}
    }
  }

  void changePassNpt({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    Response response;
    var passWord = ChangePassNptModel(
      oldPassword: oldPassword,
      confirmPassword: confirmPassword,
      newPassword: newPassword,
    );
    var jsonData = passWord.toJson();
    var token = await SharePerApi().getTokenNPT();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    // var passWordJson = passWord.toJson();
    var url = "${AppConstants.urlBaseNpt}/account/change-password-use-token";

    try {
      response = await dio.put(
        url,
        data: jsonData,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        getSnack(message: data["detail"]);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
      } else if (e.response!.statusCode == 404) {
      } else if (e.response!.statusCode == 500) {}
    }
  }

  void changePassTms({
    required String oldPassword,
    required String newPassword,
    required String reNewPassword,
  }) async {
    Response response;

    var passWord = ChangePassTmsModel(
      oldPassword: oldPassword,
      newPassword: newPassword,
      reNewPassword: reNewPassword,
    );
    var jsonData = passWord.toJson();

    var token = await SharePerApi().getTokenTMS();
    var user_tms = await SharePerApi().getIdUserTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/ChangePassword?username=$user_tms";

    try {
      response = await dio.post(
        url,
        data: jsonData,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        getSnack(message: data["message"]);
      }
    } on DioError catch (e) {
      print([e.response!.statusCode, e.response!.statusMessage]);
      if (e.response!.statusCode == 400) {
        getSnack(message: e.response!.data["message"]);
      } else if (e.response!.statusCode == 404) {
      } else if (e.response!.statusCode == 500) {}
    }
  }

  void getSnack({required String message}) {
    Get.snackbar(
      "",
      "",
      backgroundColor: Colors.white,
      titleText: const Text(
        "Thông báo",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.green,
        ),
      ),
      snackPosition: SnackPosition.TOP,
    );
  }
}
