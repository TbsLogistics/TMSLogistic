import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_driver_of_customer/model/list_tracking_model.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class CustomerListDriverDetailsOfCustomerController extends GetxController {
  RxBool showForm = true.obs;

  Rx<ListTrackingModel> statusDriver = ListTrackingModel().obs;

  GlobalKey qrKey = new GlobalKey();

  @override
  void onInit() {
    var items = Get.arguments;
    statusDriver.value = items;
    super.onInit();
  }

  void showFormStatus() {
    showForm.value = !showForm.value;
    update();
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
