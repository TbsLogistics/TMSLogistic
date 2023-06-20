// ignore_for_file: unused_local_variable, unused_catch_clause

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;

import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_qr/model/details_driver_model.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class QRCodeCustomerController extends GetxController {
  var idPhieuvao = 0.obs;
  var idDriver = 0.obs;
  Rx<DetailsDriverModel> user = DetailsDriverModel().obs;

  GlobalKey qrKey =  GlobalKey();

  @override
  void onInit() {
    var maPhieuvao = Get.arguments[0];
    idPhieuvao.value = maPhieuvao;
    var maTaixe = Get.arguments[1];
    // print("maTaixe : $maTaixe");
    idDriver.value = maTaixe;
    qrKey;
    super.onInit();
  }

  Future<Uint8List> capturePng() async {
    RenderRepaintBoundary? boundary =
        qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;

    ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();
    var bs64 = base64Encode(pngBytes);

    return pngBytes;
  }

  void onShare() async {
    var imageUint8List = await capturePng();
    await WcFlutterShare.share(
        sharePopupTitle: 'share',
        fileName: 'share.png',
        mimeType: 'image/png',
        bytesOfFile: imageUint8List);
  }

  Future<ui.Image> loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('assets/images/asd.jpg');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }

  //lấy thông tin user
  void getInfor() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenNPT();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url = "${AppConstants.urlBaseNpt}/getdetailByUsername";

    try {
      response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = DetailsDriverModel.fromJson(response.data);

        user.value = data;
      }
    } on DioError catch (e) {
      // print(e.response!.statusCode);
    }
  }
}
