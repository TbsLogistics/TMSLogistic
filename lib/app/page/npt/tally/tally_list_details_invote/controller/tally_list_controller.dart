import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/model/driver_list_ticker_model.dart';

class TallyListDetailsController extends GetxController {
  Rx<DriverListTickerModel> items = DriverListTickerModel().obs;
  @override
  void onInit() {
    var item = Get.arguments as DriverListTickerModel;
    items.value = item;
    super.onInit();
  }

  void updateTimeWork() async {
    var dio = Dio();
    Response response;
    var token = "";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var dataUpdate = {
      "id": 1,
      "name": "Hoa"
    }; // var jsonData = dataUpdate.toJson();

    var url = "";

    try {
      response = await dio.put(url,
          data: dataUpdate, options: Options(headers: headers));
      var data = response.data;
      if (data["status_code"] == 204) {
        getSnack(messageText: data["detail"]);
      } else {
        getSnack(messageText: data["detail"]);
      }
    } on DioError catch (e) {
      print([e.response!.statusCode, e.response!.statusMessage]);
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
