// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/register_driver_model.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class DriverCreateRegisterDetailsController extends GetxController {
  Rx<RegisterModel> detailsTicker = RegisterModel().obs;
  RxString id = "".obs;
  RxInt numberCont = 0.obs;
  RxString nameCustomer = "".obs;

  GlobalKey qrDriverKey = GlobalKey();
  @override
  void onInit() {
    var items = Get.arguments[0] as RegisterModel; // thong tin phieu
    var items1 = Get.arguments[1]; // id phieu
    var items2 = Get.arguments[2]; // so luong cont
    var items3 = Get.arguments[3]; // tên khách hàng
    detailsTicker.value = items;
    id.value = items1;
    numberCont.value = items2;
    nameCustomer.value = items3;
    super.onInit();
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
}
