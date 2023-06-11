// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_register_for_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_qr/model/details_driver_model.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class CustomerRegisterDetailsController extends GetxController {
  Rx<CustomerRegisterForDriverModel> detailsTicker =
      CustomerRegisterForDriverModel().obs;
  RxInt id = 0.obs;
  RxInt numberCont = 0.obs;
  RxString nameCustomer = "".obs;

  Rx<DetailsDriverModel> user = DetailsDriverModel().obs;

  GlobalKey qrKey =  GlobalKey();

  @override
  void onInit() {
    var items = Get.arguments[0] as CustomerRegisterForDriverModel;
    var items1 = Get.arguments[1];
    var items2 = Get.arguments[2]; // so luong cont
    var items3 = Get.arguments[3]; // tên khách hàng
    detailsTicker.value = items;
    id.value = items1;
    numberCont.value = items2;
    nameCustomer.value = items3;
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
}
