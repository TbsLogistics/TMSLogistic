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
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_finished/model/customer_list_registed_model.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class CustomerListTickerRegisterDetailsController extends GetxController {
  Rx<CustomerListRegistedModel> listTracking = CustomerListRegistedModel().obs;
  GlobalKey qrDriverKey = GlobalKey();

  @override
  void onInit() {
    var items = Get.arguments as CustomerListRegistedModel;
    listTracking.value = items;
    super.onInit();
  }

  void deteleTicker() async {
    var dio = Dio();
    Response response;
    var token = await SharePerApi().getTokenNPT();
    var url =
        '${AppConstants.urlBaseNpt}/invote/delete/${listTracking.value.pdriverInOutWarehouseCode}';
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    try {
      response = await dio.delete(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        if (response.data["status_code"] == 204) {
          getSnack(messageText: response.data["detail"]);
        } else {
          getSnack(messageText: response.data["detail"]);
          Get.offAllNamed(Routes.CUSTOMER_PAGE);
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {}
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
