// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_qr/controller/customer_qr_controller.dart';

class QrCodeFromDetailsCustomerScreen
    extends GetView<QRCodeCustomerController> {
  const QrCodeFromDetailsCustomerScreen({super.key});
  final String routes = "/QR_CODE_FROM_DETALS_CUSTOMER_SCREEN";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<QRCodeCustomerController>(
      init: QRCodeCustomerController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "QR Code",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: RepaintBoundary(
                  key: controller.qrKey,
                  child: FutureBuilder(
                    future: controller.loadOverlayImage(),
                    builder: (ctx, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox(width: 280, height: 280);
                      }
                      return QrImage(
                        backgroundColor: Colors.white,
                        data:
                            "${controller.idPhieuvao.value},${controller.idDriver.value}",
                        version: QrVersions.auto,
                        size: size.width * 0.6,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton.icon(
                  onPressed: controller.onShare,
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Share",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
