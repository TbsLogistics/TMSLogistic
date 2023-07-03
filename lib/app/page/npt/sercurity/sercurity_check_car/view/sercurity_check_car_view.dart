import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';

import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_check_car/controller/sercurity_check_car_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_check_car/modules/security_car_in_screen.dart';

class SercurityScreen extends GetView<SercurityCheckCarController> {
  const SercurityScreen({super.key});

  final String routes = "/SERCURITY_SCREEN";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.backgroundAppbar,
        title: const Text(
          "Kiểm tra xe ra/vào",
          style: CustomTextStyle.tilteAppbar,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
      ),
      body: GetBuilder<SercurityCheckCarController>(
        init: SercurityCheckCarController(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () {
                  controller.scanQr(idCode: "Vao");
                },
                icon: const Icon(Icons.qr_code_2_outlined),
                label: const Text("Quét mã"),
              ),
              const SercurityCarInScreen()
            ],
          ),
        ),
      ),
    );
  }
}
