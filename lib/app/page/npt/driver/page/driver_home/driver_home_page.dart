// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_home/controller/driver_home_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_home/view/driver_screen.dart';

class DriverPage extends GetView<DriverHomeController> {
  DriverPage({super.key});

  String routes = "/DRIVER_PAGE";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.toNamed(Routes.HOME_PAGE);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 24,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "ĐĂNG TÀI TÀI XẾ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColor.backgroundAppbar,
      ),
      body: const DriverScreen(),
    );
  }
}
