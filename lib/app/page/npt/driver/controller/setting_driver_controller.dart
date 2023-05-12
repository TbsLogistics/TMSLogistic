import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/model/driver_model.dart';

class SettingDriverController extends GetxController {
  RxBool hideShowMode = true.obs;
  Rx<DriverModel> user = DriverModel().obs;
  RxBool switchValue = true.obs;
  RxBool switchLanguage = true.obs;

  @override
  void onInit() {
    getInfor();

    super.onInit();
  }

  void switchHideShow() {
    hideShowMode.value = !hideShowMode.value;
    update();
  }

  void switchLight(bool value) {
    GetStorage("MyStorage").write(AppConstants.THEME_KEY, value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    switchValue.value;
    update();
  }

  void switchLanguag() {
    switchLanguage.value;
    update();
  }

  //lấy thông tin user
  void getInfor() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenNPT();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url = "${AppConstants.urlBaseNpt}/getdetailByUsername";

    try {
      response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = DriverModel.fromJson(response.data);

        user.value = data;
      }
    } on DioError catch (e) {
      print(e.response!.statusCode);
    }
  }

  @override
  void onClose() {
    Get.deleteAll();
    super.onClose();
  }
}
