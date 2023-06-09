// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself/model/user_hrm_model.dart';
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';

class ManagerLeaveFormController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var dio = Dio();

  RxBool isChangePage = false.obs;
  RxBool isUserInfo = false.obs;

  final userName = UserHrmModel().obs;

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Đơn của tôi'),
    const Tab(text: 'Đơn cần duyệt'),
  ];

  final List<Tab> myTabsManager = <Tab>[
    const Tab(text: 'Đơn cần duyệt'),
    const Tab(text: 'Đơn của tôi'),
  ];

  late TabController controller;

  @override
  void onInit() {
    controller = TabController(vsync: this, length: myTabs.length);
    getInfo();

    super.onInit();
  }

  void getInfo() async {
    var tokens = await SharePerApi().getTokenHRM();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    const url = "${AppConstants.urlBaseHrm}/getEmpInfo";
    isUserInfo(false);
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        var data = UserHrmModel.fromJson(response.data["rData"]);
        userName.value = data;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(
            messageText: "Lỗi thông tin, vui lòng thử lại trong giây lát !");
      } else if (e.response!.statusCode == 500) {
        getSnack(
            messageText: "Lỗi thông tin, vui lòng thử lại trong giây lát !");
      }
    } finally {
      isUserInfo(true);
    }
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
