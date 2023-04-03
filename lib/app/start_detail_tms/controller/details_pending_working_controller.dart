import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/model/tms_orders_model.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class DetailsPendingWorkingController extends GetxController {
  Rx<GetDataHandlingMobiles> handingMobiles = GetDataHandlingMobiles().obs;
  var idChuyen = "".obs;
  var idPTVC = "".obs;
  var isLoad = true.obs;

  @override
  void onInit() {
    var getData = Get.arguments[0] as GetDataHandlingMobiles;
    handingMobiles.value = getData;
    var maChuyen = Get.arguments[1];
    idChuyen.value = maChuyen;
    var maPTVC = Get.arguments[2];
    idPTVC.value = maPTVC;

    handingMobiles.value = getData;
    super.onInit();
  }

  void postSetRuningTypeFull({required String handlingId}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    isLoad(false);

    var url =
        "${AppConstants.urlBase}/api/Mobile/ChangeStatusHandling?id=$handlingId&maChuyen=${idChuyen.value}";
    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        handingMobiles.value;

        var data = response.data;
        // await Get.toNamed(Routes.START_DETAIL_TMS);
        Get.back();
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
            "${data["message"]}",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        // print(e.response!.statusCode);
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
            "${e.response!.data["message"]}",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    } finally {
      isLoad(true);
    }
  }

  void postSetRuning({required String maChuyen}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBase}/api/Mobile/SetRuningLessType?maChuyen=$maChuyen";
    try {
      response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
        data: {},
      );

      if (response.statusCode == 200) {
        print("oke");

        Get.back();

        Get.snackbar("Thông báo", "Bắt đầu chuyến đi thành công !",
            titleText: const Text(
              "Thông báo",
              style: TextStyle(
                color: Colors.green,
              ),
            ));
        var data = response.data;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        Get.snackbar("Thông báo", "Lỗi thực thi");
      }
    }
  }
}
