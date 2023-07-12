import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/model/driver_list_ticker_model.dart';

class SercurityListDangTaiController extends GetxController {
  RxList<DriverListTickerModel> listDangtai = <DriverListTickerModel>[].obs;
  RxBool isLoad = false.obs;

  @override
  void onInit() {
    getListDangTai();
    super.onInit();
  }

  void getListDangTai() async {
    var dio = Dio();
    Response response;
    var token = await SharePerApi().getTokenNPT();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    isLoad(false);
    const url = "${AppConstants.urlBaseNpt}/invote/read";
    try {
      response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = response.data;
        if (data["status_code"] == 204) {
          getSnack(messageText: data["detail"]);
        } else if (data["status_code"] == 200) {
          List data1 = data["data"];
          listDangtai.value =
              data1.map((e) => DriverListTickerModel.fromJson(e)).toList();
          isLoad(true);
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {}
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
