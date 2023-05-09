// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/hrm/manager_leave_form/model/day_of_letter_single_model.dart';
import 'package:tbs_logistics_tms/app/hrm/manager_leave_form/model/user_model.dart';
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

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
  RxBool isLoadDayOff = true.obs;
  RxList<DayOffLettersSingleModel> listDayOff =
      <DayOffLettersSingleModel>[].obs;

  late TabController controller;

  @override
  void onInit() {
    controller = TabController(vsync: this, length: myTabs.length);
    getInfo();
    getDayOffLetterSingler(astatus: "", needAppr: 0);

    super.onInit();
  }

  void getDayOffLetterSingler(
      {required int needAppr, required String astatus}) async {
    var dio = Dio();

    var tokens = await SharePerApi().getTokenHRM();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    isLoadDayOff(false);
    isUserInfo(false);

    var url =
        "${AppConstants.urlBaseHrm}/day-off-letters?needAppr=$needAppr&astatus=$astatus";

    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data["rData"];

        listDayOff.value =
            data.map((e) => DayOffLettersSingleModel.fromJson(e)).toList();
      }
    } catch (e) {
      rethrow;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoadDayOff(true);
        isUserInfo(true);
      });
    }
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
    } catch (e) {
      rethrow;
    } finally {
      isUserInfo(true);
    }
  }
}
