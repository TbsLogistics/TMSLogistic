import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class NotePendingController extends GetxController {
  TextEditingController noteController = TextEditingController();

  var dio = Dio();
  var handlingId = 0.obs;

  @override
  void onInit() {
    var idHanlding = Get.arguments;
    handlingId.value = idHanlding;
    super.onInit();
  }

  void postWriteNote({required String note}) async {
    var tokens = await SharePerApi().getTokenTMS();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/WriteNoteHandling?handlingId=${handlingId.value}&note=$note";

    try {
      response = await dio.post(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = response.data;
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
            "${data["message"]}",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: e.response!.data["message"]);
      }
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
