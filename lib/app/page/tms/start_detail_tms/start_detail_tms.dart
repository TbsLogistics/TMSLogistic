// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/page/tms/start_detail_tms/controller/start_detail_tms_controller.dart';

class StartDetailTms extends GetView<StartDetailTmsController> {
  const StartDetailTms({super.key});
  final String routes = "/START_DETAIL_TMS";

  @override
  Widget build(BuildContext context) {
    var day = DateFormat("dd-MM-yyyy");
    var hour = DateFormat("hh:mm a");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Chi tiết chuyến"),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        backgroundColor: CustomColor.backgroundAppbar,
        leading: IconButton(
          onPressed: () {
            Get.back(result: true);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: GetBuilder<StartDetailTmsController>(
          init: StartDetailTmsController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orangeAccent),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        controller.postSetRuning(
                          id: controller.detailOrder.value
                              .getDataHandlingMobiles![0].handlingId!,
                        );
                      },
                      child: const Text(
                        "Bắt đầu chuyến",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Obx(
                      () => ReorderableListView.builder(
                        itemCount: controller
                            .detailOrder.value.getDataHandlingMobiles!.length,
                        itemBuilder: (ctx, i) {
                          return Container(
                            key: Key('$i'),
                            // color: Colors.orangeAccent.withOpacity(0.6),
                            child: ReorderableDragStartListener(
                              index: i,
                              child: Card(
                                shadowColor: Colors.amberAccent,
                                borderOnForeground: true,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        width: 64,
                                        height: 64,
                                        padding: const EdgeInsets.all(8),
                                        child: const Card(
                                          color: Colors.white,
                                          elevation: 2,
                                          child: Center(child: Text("ICON")),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.detailOrder.value.getDataHandlingMobiles![i].diemLayHang} - ${controller.detailOrder.value.getDataHandlingMobiles![i].diemTraHang}",
                                          ),
                                          const SizedBox(height: 10),
                                          const Text("Địa chỉ : "),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        onReorder: (oldIndex, newIndex) {
                          controller.onReorder(oldIndex, newIndex);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
