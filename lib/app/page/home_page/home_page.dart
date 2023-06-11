// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/home_page/controller/home_controller.dart';
import 'package:tbs_logistics_tms/app/page/home_page/modules/drawer.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  String routes = "/HOME_PAGE";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            'TBS Logistics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        drawer: const DrawerScreen(),
        body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                  // Center(
                  //   child: Text('Update info: ${controller.updateInfo}'),
                  // ),
                  // ElevatedButton(
                  //   child: Text('Check for Update'),
                  //   onPressed: () => controller.checkForUpdate(),
                  // ),
                  Obx(
                    () => controller.tokenTms.value != ""
                        ? _buildForm(
                            size: size,
                            color: Colors.orangeAccent,
                            title: "TMS",
                            text: "Quản lý chuyến xe của Tài xế",
                            onTap: () {
                              Get.toNamed(Routes.TMS_PAGE);
                            },
                          )
                        : _buildForm(
                            size: size,
                            color: Colors.grey,
                            title: "TMS",
                            text: "Quản lý chuyến xe của Tài xế",
                            onTap: () {},
                          ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => controller.tokenNpt.value != ""
                        ? _buildForm(
                            size: size,
                            color: Colors.orangeAccent,
                            title: "NPT",
                            text: "Quản lý đăng tài",
                            onTap: () {
                              // print(controller.user_npt.value.role);
                              if (controller.user_npt.value.role == "TX") {
                                Get.toNamed(Routes.DRIVER_PAGE);
                              } else {
                                Get.toNamed(Routes.CUSTOMER_PAGE);
                              }
                            },
                          )
                        : _buildForm(
                            size: size,
                            color: Colors.grey,
                            title: "NPT",
                            text: "Quản lý đăng tài",
                            onTap: () {},
                          ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => controller.tokenHrm.value != ""
                        ? _buildForm(
                            size: size,
                            color: Colors.orangeAccent,
                            title: "HRM",
                            text: "Đăng ký nghỉ phép",
                            onTap: () {
                              Get.toNamed(Routes.MANAGER_LEAVE_FORM_SCREEN);
                            },
                          )
                        : _buildForm(
                            size: size,
                            color: Colors.grey,
                            title: "HRM",
                            text: "Đăng ký nghỉ phép",
                            onTap: () {},
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm({
    required Size size,
    required Color color,
    required String title,
    required String text,
    required VoidCallback onTap,
  }) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 8,
      color: color,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 3,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 100,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
