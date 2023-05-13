import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/tms/camera/model/list_doc_type.dart';
import 'package:tbs_logistics_tms/app/page/tms/camera/model/list_image_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait/model/tms_order_model.dart';

class CameraController extends GetxController {
  var transportId = 0.obs;
  var handlingId = 0.obs;
  var idPlaced = 0.obs;

  var selectedValue = 0.obs;
  var maLoaiChungTu = 0.obs;
  var subFee = "".obs;

  RxList<ListImageModel> image = <ListImageModel>[].obs;
  TextEditingController noteController = TextEditingController();
  TextEditingController contController = TextEditingController();
  TextEditingController sealController = TextEditingController();

  @override
  void onInit() {
    var handingMobiles = Get.arguments[0] as GetDataHandlingMobiles;
    var idTransport = handingMobiles.maVanDon;
    var idHanlding = handingMobiles.handlingId;
    var idPlacing = Get.arguments[1];

    transportId.value = int.parse(idTransport.toString());
    handlingId.value = int.parse(idHanlding.toString());
    idPlaced.value = idPlacing;
    getListImage();
    getImage();
    super.onInit();
  }

  void uploadImages({
    required String file,
    required String note,
    required int docType,
  }) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url = "${AppConstants.urlBaseTms}/api/Mobile/CreateDoc";
    final formData = FormData.fromMap({
      'handlingId': handlingId.value,
      'docType': selectedValue.value,
      'note': note,
      'contNo': contController.text,
      'sealNp': sealController.text,
      'fileImage':
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
      if (e.response!.statusCode == 400) {
        getSnack(message: e.response!.data["message"]);
      } else if (e.response!.statusCode == 500) {
        getSnack(message: "Lỗi máy chủ");
      }
    }
  }

  void getListImage() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/GetListImage?handlingId=${handlingId.value}";

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
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/GetImageById?idImage=${handlingId.value}";

    try {
      response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        var data = response.data;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: e.response!.data["message"]!);
      }
    }
  }

  Future<List<ListDocTypeModel>> getListDocType(query) async {
    var tokens = await SharePerApi().getTokenTMS();
    Response response;
    var dio = Dio();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/GetListDocType?placeId=${idPlaced.value}";
    // var url = "${AppConstants.urlBaseTms}/api/Mobile/GetListDocType?placeId=221";

    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: {"query": query},
      );
      if (response.statusCode == 200) {
        var data = response.data;
        if (data != null) {
          return ListDocTypeModel.fromJsonList(data);
        }
        return [];
      }
      return [];
    } catch (e) {
      rethrow;
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
