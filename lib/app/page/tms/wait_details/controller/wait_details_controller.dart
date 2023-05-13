import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait/model/tms_order_model.dart';

class AwaitDetailsController extends GetxController {
  Rx<TmsOrdersModel> detailOrder = TmsOrdersModel().obs;
  TextEditingController contNoController = TextEditingController();

  RxList<String> items = ['Item 1', 'Hello 2', 'Win 3', 'Item 4'].obs;

  @override
  void onInit() {
    var orDerDriver = Get.arguments as TmsOrdersModel;
    detailOrder.value = orDerDriver;
    super.onInit();
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
  }

  //Bắt đầu chuyến
  void postSetRuning({required int id}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/ChangeStatusHandling?id=$id&maChuyen=${detailOrder.value.maChuyen}";
    try {
      response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;

        Get.back(result: true);
        getSnack(message: data["message"]);

        detailOrder.value;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: e.response!.data);
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
