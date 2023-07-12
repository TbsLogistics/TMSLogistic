// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait/controller/wait_controller.dart';

class TmsAwait extends GetView<AwaitController> {
  const TmsAwait({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var hours = DateFormat("dd/MM/yyyy HH:mm");
    return GetBuilder<AwaitController>(
      init: AwaitController(),
      builder: (controller) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.listOrder.length,
                    itemBuilder: (ctx, i) {
                      return _customeListTitle(
                        size,
                        title: "Mã chuyến :",
                        content: "${controller.listOrder[i].maChuyen}",
                        sub1: controller.listOrder[i].thoiGianLayRong != null
                            ? "Thời gian Lấy rỗng :"
                            : controller.listOrder[i].thoiGianTraRong != null
                                ? "Thời gian Trả rỗng :"
                                : controller.listOrder[i].thoiGianHaCang != null
                                    ? "Thời gian Hạ cảng :"
                                    : controller.listOrder[i].thoiGianHanLenh !=
                                            null
                                        ? "Thời gian Hạn lệnh :"
                                        : "",
                        subContent1: controller.listOrder[i].thoiGianLayRong !=
                                null
                            ? hours.format(DateTime.parse(
                                "${controller.listOrder[i].thoiGianLayRong}"))
                            : controller.listOrder[i].thoiGianTraRong != null
                                ? hours.format(DateTime.parse(
                                    "${controller.listOrder[i].thoiGianTraRong}"))
                                : controller.listOrder[i].thoiGianHaCang != null
                                    ? hours.format(DateTime.parse(
                                        "${controller.listOrder[i].thoiGianHaCang}"))
                                    : controller.listOrder[i].thoiGianHanLenh !=
                                            null
                                        ? hours.format(DateTime.parse(
                                            "${controller.listOrder[i].thoiGianHanLenh}"))
                                        : "",
                        sub2: controller.listOrder[i].getDataHandlingMobiles![0]
                                    .maDiemLayRong ==
                                ""
                            ? "Điểm lấy hàng :"
                            : "Điểm lấy rỗng :",
                        subContent2: controller.listOrder[i]
                                    .getDataHandlingMobiles![0].maDiemLayRong ==
                                null
                            ? controller.listOrder[i].getDataHandlingMobiles![0]
                                .diemLayHang!
                            : controller.listOrder[i].getDataHandlingMobiles![0]
                                .diemLayRong!,
                        sub3: "ContNo :",
                        subContent3: controller.listOrder[i]
                                .getDataHandlingMobiles![0].contNo ??
                            "",
                        sub4: "BookingNo :",
                        subContent4: controller.listOrder[i]
                                .getDataHandlingMobiles![0].bookingNo ??
                            "",
                        onTap: () async {
                          var result = await Get.toNamed(
                            Routes.START_DETAIL_TMS,
                            arguments: controller.listOrder[i],
                          );
                          if (result is bool && result == true) {
                            controller.getData();
                          }
                        },
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _customeListTitle(
    Size size, {
    required String title,
    required String content,
    required String sub1,
    required String subContent1,
    required String sub2,
    required String subContent2,
    required String sub3,
    required String subContent3,
    required String sub4,
    required String subContent4,
    required Function()? onTap,
  }) {
    const double height = 5;
    return Card(
      shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orangeAccent, width: 1),
          borderRadius: BorderRadius.circular(5)),
      shadowColor: Colors.grey.shade300,
      elevation: 10,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 150,
          width: size.width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: height,
                          ),
                          Text(
                            content,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sub1,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: height,
                          ),
                          Text(
                            subContent1,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sub2,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: height,
                          ),
                          Text(
                            subContent2,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sub3,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: height,
                          ),
                          Text(
                            subContent3,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sub4,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: height,
                          ),
                          Text(
                            subContent4,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
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
