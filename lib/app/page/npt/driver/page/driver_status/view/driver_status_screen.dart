// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/controller/driver_status_controller.dart';

class DriverStatusScreen extends GetView<DriverStatusController> {
  const DriverStatusScreen({super.key});
  final String routes = "/LIST_STATUS_INFINISHED_SCREEN";

  @override
  Widget build(BuildContext context) {
    var day = DateFormat("dd-MM-yyyy");
    var hour = DateFormat("hh-mm a");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Phiếu chưa hoàn thành của tài xế",
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).primaryColorLight,
            size: 25,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: GetBuilder<DriverStatusController>(
          init: DriverStatusController(),
          builder: (controller) {
            return controller.isLoadList.value
                ? Obx(
                    () => ListView.builder(
                      itemCount: controller.listDriverFinishedScreen.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shadowColor: Colors.grey,
                          elevation: 10,
                          shape: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              Get.toNamed(
                                Routes.LIST_STATUS_UNFINISHED_DETAIL_SCREEN,
                                arguments: controller
                                    .listDriverFinishedScreen.value[index],
                              );
                            },
                            title: Row(
                              children: [
                                Text(
                                  "${controller.listDriverFinishedScreen.value[index].pdriverInOutWarehouseCode}",
                                  style: TextStyle(
                                    color: controller.listDriverFinishedScreen
                                                .value[index].giovao !=
                                            null
                                        ? Colors.red
                                        : Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${controller.listDriverFinishedScreen.value[index].khoRe!.tenKho}",
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "${controller.listDriverFinishedScreen[index].loaixe!.tenLoaiXe}",
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "${controller.listDriverFinishedScreen[index].soxe}",
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Giờ dự kiến",
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                                Text(day.format(
                                  DateTime.parse(
                                    controller.listDriverFinishedScreen[index]
                                        .giodukien
                                        .toString(),
                                  ),
                                )),
                                Text(hour.format(
                                  DateTime.parse(
                                    controller.listDriverFinishedScreen[index]
                                        .giodukien
                                        .toString(),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orangeAccent,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
