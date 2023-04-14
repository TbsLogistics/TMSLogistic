import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/model/tms_orders_model.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class TmsWorkingController extends GetxController {
  var dio = Dio();
  late Response response;

  RxList<TmsOrdersModel> listOrder = <TmsOrdersModel>[].obs;

  RxBool isLoad = true.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    var token = await SharePerApi().getToken();
    var idTX = await SharePerApi().getIdTX();
    var status = false;
    var url =
        "${AppConstants.urlBase}/api/Mobile/GetDataTransport?driver=$idTX&isCompleted=$status";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    isLoad(false);
    response = await dio.get(
      url,
      options: Options(
        headers: headers,
      ),
    );
    try {
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        listOrder.value = data.map((e) => TmsOrdersModel.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: "${e.response!.data["message"]}");
        // return [];
      }
    } finally {
      isLoad(true);
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
    );
  }
}
