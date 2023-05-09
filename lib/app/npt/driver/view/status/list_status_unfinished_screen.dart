import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:tbs_logistics_tms/app/npt/driver/view/status/controller/list_status_uninished_controller.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';

class ListStatusUnfinishedScreen
    extends GetView<ListStatusUnfinishedController> {
  const ListStatusUnfinishedScreen({super.key});
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
        child: GetBuilder<ListStatusUnfinishedController>(
          init: ListStatusUnfinishedController(),
          builder: (controller) {
            return controller.isLoadList.value
                ? Obx(
                    () => ListView.builder(
                      itemCount: controller.listStatusDriver.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              Get.toNamed(
                                Routes.LIST_STATUS_UNFINISHED_DETAIL_SCREEN,
                                arguments:
                                    controller.listStatusDriver.value[index],
                              );
                            },
                            title: Row(
                              children: [
                                Text(
                                  "${controller.listStatusDriver.value[index].khuVuc!.maKhuVuc}",
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${controller.listStatusDriver.value[index].phieuvao!.kho!.tenKho}",
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "${controller.listStatusDriver[index].loaixeRe!.tenLoaiXe}",
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "${controller.listStatusDriver[index].phieuvao!.soxe}",
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
                                    controller.listStatusDriver[index].phieuvao!
                                        .giodukien
                                        .toString(),
                                  ),
                                )),
                                Text(hour.format(
                                  DateTime.parse(
                                    controller.listStatusDriver[index].phieuvao!
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