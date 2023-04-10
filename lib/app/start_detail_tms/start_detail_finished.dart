// ignore_for_file: unused_local_variable, avoid_unnecessary_containers

import "dart:math" as math;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/controller/start_detail_finished_controller.dart';
import 'package:tbs_logistics_tms/config/core/data/color.dart';

class FinishedDetailTms extends GetView<StartDetailFinishedController> {
  const FinishedDetailTms({super.key});
  final String routes = "/FINISHED_DETAIL_TMS";

  @override
  Widget build(BuildContext context) {
    var day = DateFormat("dd-MM-yyyy");
    var hour = DateFormat("hh:mm a");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
      body: GetBuilder<StartDetailFinishedController>(
        init: StartDetailFinishedController(),
        builder: (controller) => Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Obx(
                () {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          controller.listReceiveEmpty.isNotEmpty
                              ? _buildReciveEmpty()
                              : Container(),
                          controller.listReceive.isNotEmpty
                              ? _buildRecive()
                              : Container(),
                          controller.listGive.isNotEmpty
                              ? _buildGive()
                              : Container(),
                          controller.listGiveEmpty.isNotEmpty
                              ? _buildGiveEmpty()
                              : Container(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReciveEmpty() {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Color(0xffE18229),
                            iconSize: 35.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        const Expanded(
                            child: Text(
                          "Điểm lấy rỗng",
                          style: TextStyle(
                              color: Colors.orangeAccent, fontSize: 18),
                        )),
                      ]),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: (180 *
                        double.parse(controller.listDataForReceiveEmpty.length
                            .toString())),
                    child: Column(
                      children: [
                        Expanded(
                          //List điểm lấy rỗng
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller.listDataForReceiveEmpty.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  height: (180 *
                                      double.parse(controller
                                          .listDataForReceiveEmpty[i]
                                          .getData!
                                          .length
                                          .toString())),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.listReceiveEmpty[i].diemLayRong}",
                                            style: const TextStyle(
                                              color: Colors.orangeAccent,
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                      // List vận đơn tại địa điểm
                                      Expanded(child: Obx(() {
                                        return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: controller
                                              .listDataForReceiveEmpty[i]
                                              .getData!
                                              .length,
                                          itemBuilder: (ctx, j) {
                                            return Card(
                                              child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  height: 170,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${controller.listDataForReceiveEmpty[i].getData![j].maVanDon}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            controller.listReceiveEmpty[j]
                                                                        .loaiVanDon ==
                                                                    "xuat"
                                                                ? "Giao hàng"
                                                                : "Nhận hàng",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          TextButton.icon(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons
                                                                    .edit_note_outlined,
                                                                color: Colors
                                                                    .orangeAccent),
                                                            label: const Text(
                                                              "Ghi chú",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .orangeAccent),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .orangeAccent),
                                                            ),
                                                            onPressed: () {},
                                                            child: const Text(
                                                                "Chứng từ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                          Obx(() {
                                                            return controller
                                                                    .isLoadStatus
                                                                    .value
                                                                ? controller
                                                                            .listOrder
                                                                            .value
                                                                            .getDataHandlingMobiles![j]
                                                                            .maTrangThai ==
                                                                        17
                                                                    ? TextButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all<Color>(Colors.red),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                        child:
                                                                            const Text(
                                                                          "Hủy hoàn thành",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      )
                                                                    : TextButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor: MaterialStateProperty.all<Color>(Colors
                                                                              .black
                                                                              .withOpacity(0.4)),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                        child: const Text(
                                                                            "Hủy hoàn thành",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                      )
                                                                : const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  );
                                                          }),
                                                          Obx(() => controller
                                                                  .isLoadStatus
                                                                  .value
                                                              ? controller
                                                                          .listOrder
                                                                          .value
                                                                          .getDataHandlingMobiles![
                                                                              j]
                                                                          .maTrangThai ==
                                                                      17
                                                                  ? TextButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(Colors.green),
                                                                      ),
                                                                      onPressed:
                                                                          () {},
                                                                      child:
                                                                          const Text(
                                                                        "Hoàn thành",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    )
                                                                  : TextButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                                                                            .black
                                                                            .withOpacity(0.4)),
                                                                      ),
                                                                      onPressed:
                                                                          () {},
                                                                      child:
                                                                          const Text(
                                                                        "Hoàn thành",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    )
                                                              : const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .orangeAccent,
                                                                  ),
                                                                ))
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          },
                                        );
                                      }))
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecive() {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    // color: Colors.indigoAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Color(0xffE18229),
                            iconSize: 35.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        const Expanded(
                            child: Text(
                          "Điểm lấy hàng",
                          style: TextStyle(
                              color: Colors.orangeAccent, fontSize: 18),
                        )),
                      ]),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: (180 *
                        double.parse(
                            controller.listDataForReceive.length.toString())),
                    child: Column(
                      children: [
                        Expanded(
                          //List điểm lấy rỗng
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.listDataForReceive.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  height: (180 *
                                      double.parse(controller
                                          .listDataForReceive[i].getData!.length
                                          .toString())),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Expanded(child: Obx(() {
                                        return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: controller
                                              .listDataForReceive[i]
                                              .getData!
                                              .length,
                                          itemBuilder: (ctx, j) {
                                            return Card(
                                              child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  height: 170,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${controller.listDataForReceive[i].getData![j].maVanDon}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            controller
                                                                        .listDataForReceive[
                                                                            i]
                                                                        .getData![
                                                                            j]
                                                                        .loaiVanDon ==
                                                                    "xuat"
                                                                ? "Giao hàng"
                                                                : "Nhận hàng",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          TextButton.icon(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons
                                                                    .edit_note_outlined,
                                                                color: Colors
                                                                    .orangeAccent),
                                                            label: const Text(
                                                              "Ghi chú",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .orangeAccent),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .orangeAccent),
                                                            ),
                                                            onPressed: () {},
                                                            child: const Text(
                                                                "Chứng từ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                          Obx(() {
                                                            return controller
                                                                    .isLoadStatus
                                                                    .value
                                                                ? controller.listOrder.value.getDataHandlingMobiles![j].maTrangThai ==
                                                                            40 ||
                                                                        controller.listOrder.value.getDataHandlingMobiles![j].maTrangThai ==
                                                                            37
                                                                    ? TextButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all<Color>(Colors.red),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                        child: const Text(
                                                                            "Hủy hoàn thành",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                      )
                                                                    : TextButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor: MaterialStateProperty.all<Color>(Colors
                                                                              .black
                                                                              .withOpacity(0.4)),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                        child:
                                                                            const Text(
                                                                          "Hủy hoành thành",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      )
                                                                : const Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: Colors
                                                                          .orangeAccent,
                                                                    ),
                                                                  );
                                                          }),
                                                          Obx(() {
                                                            return controller
                                                                    .isLoadStatus
                                                                    .value
                                                                ? controller.listOrder.value.getDataHandlingMobiles![j].maTrangThai ==
                                                                            40 ||
                                                                        controller.listOrder.value.getDataHandlingMobiles![j].maTrangThai ==
                                                                            37
                                                                    ? TextButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all<Color>(Colors.green),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                        child: const Text(
                                                                            "Hoàn thành",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                      )
                                                                    : TextButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor: MaterialStateProperty.all<Color>(Colors
                                                                              .black
                                                                              .withOpacity(0.4)),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                        child: const Text(
                                                                            "Hoàn thành",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                      )
                                                                : const Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: Colors
                                                                          .orangeAccent,
                                                                    ),
                                                                  );
                                                          })
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          },
                                        );
                                      }))
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGive() {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    // color: Colors.indigoAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Color(0xffE18229),
                            iconSize: 35.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        const Expanded(
                            child: Text(
                          "Điểm trả hàng",
                          style: TextStyle(
                              color: Colors.orangeAccent, fontSize: 18),
                        )),
                      ]),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: (180 *
                        double.parse(
                          controller.listDataForGive.length.toString(),
                        )),
                    child: Column(
                      children: [
                        Expanded(
                          //List điểm lấy rỗng
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.listDataForGive.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  height: (180 *
                                      double.parse(controller
                                          .listDataForGive[i].getData!.length
                                          .toString())),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                .listDataForGive[i].place!,
                                            style: const TextStyle(
                                              color: Colors.orangeAccent,
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                      // List vận đơn tại địa điểm
                                      Expanded(child: Obx(() {
                                        return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: controller
                                              .listDataForGive[i]
                                              .getData!
                                              .length,
                                          itemBuilder: (ctx, j) {
                                            return Card(
                                              child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  height: 170,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${controller.listDataForGive[i].getData![j].maVanDon}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            controller
                                                                        .listDataForGive[
                                                                            i]
                                                                        .getData![
                                                                            j]
                                                                        .loaiVanDon ==
                                                                    "xuat"
                                                                ? "Giao hàng"
                                                                : "Nhận hàng",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          TextButton.icon(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons
                                                                    .edit_note_outlined,
                                                                color: Colors
                                                                    .orangeAccent),
                                                            label: const Text(
                                                              "Ghi chú",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .orangeAccent),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .orangeAccent),
                                                            ),
                                                            onPressed: () {},
                                                            child: const Text(
                                                                "Chứng từ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                          Obx(() => controller
                                                                  .isLoadStatus
                                                                  .value
                                                              ? controller
                                                                          .listOrder
                                                                          .value
                                                                          .getDataHandlingMobiles![
                                                                              j]
                                                                          .maTrangThai ==
                                                                      18
                                                                  ? TextButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(Colors.red),
                                                                      ),
                                                                      onPressed:
                                                                          () {},
                                                                      child: const Text(
                                                                          "Hủy hoàn thành",
                                                                          style:
                                                                              TextStyle(color: Colors.white)),
                                                                    )
                                                                  : TextButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                                                                            .black
                                                                            .withOpacity(0.4)),
                                                                      ),
                                                                      onPressed:
                                                                          () {},
                                                                      child: const Text(
                                                                          "Hủy hoàn thành",
                                                                          style:
                                                                              TextStyle(color: Colors.white)),
                                                                    )
                                                              : const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .orangeAccent,
                                                                  ),
                                                                )),
                                                          Obx(() {
                                                            return controller
                                                                    .isLoadStatus
                                                                    .value
                                                                ? controller
                                                                            .listOrder
                                                                            .value
                                                                            .getDataHandlingMobiles![
                                                                                j]
                                                                            .maTrangThai ==
                                                                        18
                                                                    ? TextButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all<Color>(Colors.green),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                        child: const Text(
                                                                            "Hoàn thành",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                      )
                                                                    : TextButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor: MaterialStateProperty.all<Color>(Colors
                                                                              .black
                                                                              .withOpacity(0.4)),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                        child: const Text(
                                                                            "Hoàn thành",
                                                                            style:
                                                                                TextStyle(color: Colors.white)))
                                                                : const Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: Colors
                                                                          .orangeAccent,
                                                                    ),
                                                                  );
                                                          })
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          },
                                        );
                                      }))
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGiveEmpty() {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    // color: Colors.indigoAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Color(0xffE18229),
                            iconSize: 35.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        const Expanded(
                            child: Text(
                          "Điểm trả rỗng",
                          style: TextStyle(
                              color: Colors.orangeAccent, fontSize: 18),
                        )),
                      ]),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: (180 *
                        double.parse(
                          controller.listDataForGiveEmpty.length.toString(),
                        )),
                    child: Column(
                      children: [
                        Expanded(
                          //List điểm lấy rỗng
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.listDataForGiveEmpty.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  height: (180 *
                                      double.parse(controller
                                          .listDataForGiveEmpty[i]
                                          .getData!
                                          .length
                                          .toString())),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                .listDataForGiveEmpty[i].place!,
                                            style: const TextStyle(
                                              color: Colors.orangeAccent,
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                      // List vận đơn tại địa điểm
                                      Expanded(child: Obx(() {
                                        return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: controller
                                              .listDataForGiveEmpty[i]
                                              .getData!
                                              .length,
                                          itemBuilder: (ctx, j) {
                                            return Card(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                height: 170,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${controller.listDataForGiveEmpty[i].getData![j].maVanDon}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller
                                                                      .listDataForGiveEmpty[
                                                                          i]
                                                                      .getData![
                                                                          j]
                                                                      .loaiVanDon ==
                                                                  "xuat"
                                                              ? "Giao hàng"
                                                              : "Nhận hàng",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        TextButton.icon(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons
                                                                  .edit_note_outlined,
                                                              color: Colors
                                                                  .orangeAccent),
                                                          label: const Text(
                                                            "Ghi chú",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .orangeAccent),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .orangeAccent),
                                                          ),
                                                          onPressed: () {},
                                                          child: const Text(
                                                            "Chứng từ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        Obx(
                                                          () => controller
                                                                  .isLoadStatus
                                                                  .value
                                                              ? controller
                                                                          .listOrder
                                                                          .value
                                                                          .getDataHandlingMobiles![
                                                                              j]
                                                                          .maTrangThai ==
                                                                      35
                                                                  ? TextButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(Colors.red),
                                                                      ),
                                                                      onPressed:
                                                                          () {},
                                                                      child:
                                                                          const Text(
                                                                        "Hủy hoàn thành",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : TextButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                                                                            .black
                                                                            .withOpacity(0.3)),
                                                                      ),
                                                                      onPressed:
                                                                          () {},
                                                                      child:
                                                                          const Text(
                                                                        "Hủy hoàn thành",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    )
                                                              : const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .orangeAccent,
                                                                  ),
                                                                ),
                                                        ),
                                                        Obx(() => controller
                                                                .isLoadStatus
                                                                .value
                                                            ? controller
                                                                        .listOrder
                                                                        .value
                                                                        .getDataHandlingMobiles![
                                                                            j]
                                                                        .maTrangThai ==
                                                                    35
                                                                ? TextButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .green),
                                                                    ),
                                                                    onPressed:
                                                                        () {},
                                                                    child:
                                                                        const Text(
                                                                      "Hoàn thành",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : TextButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.3)),
                                                                    ),
                                                                    onPressed:
                                                                        () {},
                                                                    child:
                                                                        const Text(
                                                                      "Hoàn thành",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  )
                                                            : const Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: Colors
                                                                      .orangeAccent,
                                                                ),
                                                              )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }))
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
