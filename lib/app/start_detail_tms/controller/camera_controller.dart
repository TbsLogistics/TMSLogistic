import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:tbs_logistics_tms/app/start_detail_tms/model/list_image_model.dart';
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/model/tms_orders_model.dart';

import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class CameraController extends GetxController {
  var transportId = 0.obs;
  var handlingId = 0.obs;
  RxList<ListImageModel> image = <ListImageModel>[].obs;
  TextEditingController noteController = TextEditingController();
  @override
  void onInit() {
    var handingMobiles = Get.arguments as GetDataHandlingMobiles;
    var idTransport = handingMobiles.maVanDon;
    var idHanlding = handingMobiles.handlingId;
    transportId.value = int.parse(idTransport.toString());
    handlingId.value = int.parse(idHanlding.toString());
    getListImage();
    getImage();

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
        getSnack(message: response.data["message"]);
      }
    } on DioError catch (e) {
      print([e.response!.statusCode, e.response!.data]);
    }
  }

  void getListImage() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url =
        "${AppConstants.urlBase}/api/Mobile/GetListImage?handlingId=${handlingId.value}";

    try {
      response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        List data = response.data;
        image.value = data.map((e) => ListImageModel.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: e.response!.data["message"]!);
      }
    }
  }

  void getImage() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url = "${AppConstants.urlBase}/api/Mobile/GetImageById?idImage=203";

    try {
      response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = response.data;
        print("images: $data");
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: e.response!.data["message"]!);
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
    ;
  }
}
