import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/controller/sercurity_controller.dart';
// import 'package:tbs_logistics_tms/app/page/npt/sercurity/view/qr_code_scanner.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/view/sercurity_screen.dart';

class SercurityPage extends GetView<SercurityController> {
  final String routes = "/SERCURITY_PAGE";

  const SercurityPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.backgroundAppbar,
        title: const Text(
          "Tbs Logistics",
          style: CustomTextStyle.tilteAppbar,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
      ),
      body: const SercurityScreen(),
    );
  }
}
