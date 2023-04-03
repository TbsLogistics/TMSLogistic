import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';

import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class CancelPendingController extends GetxController {
  var handlingId = 0.obs;
  TextEditingController cancelController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    formKey;
    var idHanlding = Get.arguments;
    handlingId.value = idHanlding;
    super.onInit();
  }

  void postCancel() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBase}/api/Mobile/CancelHandling?handlingId=${handlingId.value}";
    try {
      response = await dio.post(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = response.data;

        Get.back(result: true);

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
            "${e.response!.data["message"]}",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    }
  }
}
