import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';

import 'package:tbs_logistics_tms/app/page/npt/driver/controller/driver_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/view/status_tiker_finished/status_tiker_view.dart';

class DriverScreen extends GetView<DriverController> {
  const DriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<DriverController>(
      init: DriverController(),
      builder: (controller) => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            children: [
              Container(
                height: size.height * 0.2,
                width: size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage(
                      "assets/images/background.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.1),
              GestureDetector(
                onTap: () {
                  // Get.to(() => const RegisterFormScreen());

                  Get.toNamed(Routes.CREATE_REGISTER_DRIVER);
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Colors.orangeAccent.withOpacity(0.6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.create_outlined, size: 30),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Text(
                        "Đăng ký phiếu vào",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.1),
              GestureDetector(
                onTap: () {
                  // Get.to(() => StatusDriverScreen());
                  Get.toNamed(Routes.LIST_STATUS_INFINISHED_SCREEN);
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Colors.orangeAccent.withOpacity(0.6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.create_outlined, size: 30),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Text(
                        "Danh sách chưa hoàn thành",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.1),
              GestureDetector(
                onTap: () {
                  Get.to(() => const StatusDriver());
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Colors.orangeAccent.withOpacity(0.6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.create_outlined, size: 30),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Text(
                        "Danh sách các phiếu đã đăng ký",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
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
