// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/npt/driver/controller/driver_controller.dart';
import 'package:tbs_logistics_tms/app/npt/driver/view/driver_screen.dart';
import 'package:tbs_logistics_tms/config/core/data/color.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';

class DriverPage extends GetView<DriverController> {
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
