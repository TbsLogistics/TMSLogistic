// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/model/driver_list_ticker_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status_details/model/list_driver_by_customer_model.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class DriverStatusDetailsController extends GetxController {
  var dio = Dio();

  Rx<DriverListTickerModel> getDriverFinishedScreen =
      DriverListTickerModel().obs;
  GlobalKey qrDriverKey = GlobalKey();

  RxBool isDriverFinishedScreen = true.obs;
  RxBool showForm = false.obs;

  @override
  void onInit() {
    var driverFinishedScreen = Get.arguments as DriverListTickerModel;
    getDriverFinishedScreen.value = driverFinishedScreen;

    super.onInit();
  }

  void showFormStatus() {
    showForm.value = !showForm.value;
    update();
  }

  var selectedTaixe = "";

  void deteleTicker({required String maPhieu}) async {
    Response response;
    var token = await SharePerApi().getTokenNPT();
    var url = '${AppConstants.urlBaseNpt}/invote/delete/$maPhieu';
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        if (response.data["status_code"] == 204) {
          getSnack(messageText: response.data["detail"]);
        } else {
          getSnack(messageText: response.data["detail"]);
          Get.offAllNamed(Routes.HOME_PAGE);
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {}
    }
  }

  Future<List<ListDriverByCustomerModel>> getData(query) async {
    Response response;
    var token = await SharePerApi().getTokenNPT();
    var idHK = await SharePerApi().getIdKHforTX();
    // print(idHK);

    var url =
        '${AppConstants.urlBaseNpt}/listdriverbycustomerID?maKhachHang=$idHK';
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: {"query": query},
      );

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var customer = response.data;
        if (customer != null) {
          return ListDriverByCustomerModel.fromJsonList(customer);
        }
        return [];
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  void shareDriver({required int maTaiXe, required int maPhieuVao}) async {
    Response response;

    var url =
        "${AppConstants.urlBaseNpt}/share-entry-vote-in?maTaiXe=$maTaiXe&maPhieuVao=$maPhieuVao";
    try {
      response = await dio.post(url);
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        Get.back();
        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Color.fromARGB(199, 230, 16, 16),
            ),
          ),
          messageText: const Text(
            "Chia sẻ phiếu thành công !",
            style: TextStyle(
              color: Color.fromARGB(197, 8, 197, 43),
            ),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  void onShare() async {
    var imageUint8List = await capturePng();
    await WcFlutterShare.share(
        sharePopupTitle: 'share',
        fileName: 'share.png',
        mimeType: 'image/png',
        bytesOfFile: imageUint8List);
  }

  Future<Uint8List> capturePng() async {
    RenderRepaintBoundary? boundary = qrDriverKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;

    ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();
    var bs64 = base64Encode(pngBytes);

    return pngBytes;
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
