import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/model/tms_orders_model.dart';

import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';
import 'package:dio/src/form_data.dart';

class CameraController extends GetxController {
  var transportId = 0.obs;
  var handlingId = 0.obs;
  TextEditingController noteController = TextEditingController();
  @override
  void onInit() {
    var handingMobiles = Get.arguments as GetDataHandlingMobiles;
    var idTransport = handingMobiles.maVanDon;
    var idHanlding = handingMobiles.handlingId;
    transportId.value = int.parse(idTransport.toString());
    handlingId.value = int.parse(idHanlding.toString());

    super.onInit();
  }

  void uploadImages({required String file, required String note}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    print(await MultipartFile.fromFile(file, filename: 'upload.txt'));
    var url = "${AppConstants.urlBase}/api/Mobile/UploadImage";
    final formData = FormData.fromMap({
      'note': note,
      'transportId': transportId.value,
      'handlingId': handlingId.value,
      'files':
          await MultipartFile.fromFile(file, filename: file.split("/").last),
    });
    try {
      response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
        data: formData,
      );
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar(
          "Thông báo",
          "Nhập thiếu tài khoản hoặc mật khẩu !",
          backgroundColor: Colors.white,
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: Text(
            "${response.data["message"]}",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    } on DioError catch (e) {
      print([e.response!.statusCode, e.response!.data["message"]]);
    }
  }
}
