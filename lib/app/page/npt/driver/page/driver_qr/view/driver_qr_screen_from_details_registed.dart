import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_qr/controller/driver_qr_controller.dart';

class QrCodeDetailsRegistedDriverScreen
    extends GetView<QRCodeDriverController> {
  const QrCodeDetailsRegistedDriverScreen({super.key});
  final String routes = "/QR_CODE_DETAILS_REGISTED_DRIVER_SCREEN";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<QRCodeDriverController>(
      init: QRCodeDriverController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "QR Code",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.DRIVER_PAGE);
              },
              icon: Icon(
                Icons.home,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: RepaintBoundary(
                  key: controller.qrDriverKey,
                  child: Obx(
                    () => QrImage(
                      backgroundColor: Colors.white,
                      data:
                          "${controller.idPhieuvao.value},${controller.user.value.maTaixe}",
                      version: QrVersions.auto,
                      size: size.width * 0.6,
                    ),
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
