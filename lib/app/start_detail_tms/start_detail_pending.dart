import "dart:math" as math;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:tbs_logistics_tms/app/start_detail_tms/controller/start_detail_pending_controller.dart';
import 'package:tbs_logistics_tms/config/core/data/color.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';

class PendingDetailTms extends GetView<StartDetailPendingController> {
  const PendingDetailTms({super.key});
  final String routes = "/PENDING_DETAIL_TMS";

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
      body: GetBuilder<StartDetailPendingController>(
        init: StartDetailPendingController(),
        builder: (controller) => Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Obx(
                        () => controller.listOrder.value.loaiPhuongTien ==
                                        "CONT40" &&
                                    controller
                                            .listOrder
                                            .value
                                            .getDataHandlingMobiles![0]
                                            .contNo ==
                                        null ||
                                controller.listOrder.value.loaiPhuongTien ==
                                        "CONT20" &&
                                    controller
                                            .listOrder
                                            .value
                                            .getDataHandlingMobiles![0]
                                            .contNo ==
                                        null
                            ? TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.orangeAccent),
                                ),
                                onPressed: () {
                                  Get.defaultDialog(
                                    backgroundColor: Colors.white,
                                    title: "Thông báo",
                                    titleStyle: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            maxLines: 3,
                                            controller:
                                                controller.contController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.orangeAccent,
                                                ),
                                              ),
                                              hintText: "Nhập Cont",
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 20,
                                                bottom: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    confirm: Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.orangeAccent,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextButton(
                                        onPressed: () {
                                          controller.updateContNo(
                                            contNo:
                                                controller.contController.text,
                                            maChuyen:
                                                '${controller.listOrder.value.maChuyen}',
                                          );
                                        },
                                        child: const Text(
                                          "Xác nhận",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Nhập ContNo",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.black.withOpacity(0.4),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Bắt đầu chuyến",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          controller.listReceiveEmpty.value.isNotEmpty
                              ? _buildReciveEmpty()
                              : Container(),
                          controller.listReceive.value.isNotEmpty
                              ? _buildRecive()
                              : Container(),
                          controller.listGive.value.isNotEmpty
                              ? _buildGive()
                              : Container(),
                          controller.listGiveEmpty.value.isNotEmpty
                              ? _buildGiveEmpty()
                              : Container(),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Kết thúc chuyến",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                Routes
                                                                    .NOTE_PENDING_SCREEN,
                                                                arguments: controller
                                                                    .listDataForReceiveEmpty[
                                                                        i]
                                                                    .getData![j]
                                                                    .handlingId,
                                                              );
                                                            },
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
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                Routes.CAMERA,
                                                                arguments: controller
                                                                    .listDataForReceiveEmpty[
                                                                        i]
                                                                    .getData![j],
                                                              );
                                                            },
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
                                                                            () async {
                                                                          var result =
                                                                              await Get.toNamed(
                                                                            Routes.CANCEL_PENDING_SCREEN,
                                                                            arguments:
                                                                                controller.listDataForReceiveEmpty[i].getData![j].handlingId,
                                                                          );
                                                                          if (result is bool &&
                                                                              result == true) {
                                                                            controller.listOrder.value.getDataHandlingMobiles![j].maTrangThai;
                                                                          }
                                                                        },
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
                                                                          () async {
                                                                        var result =
                                                                            await Get.defaultDialog(
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          title:
                                                                              "Thông báo",
                                                                          content:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: const [
                                                                              Text(
                                                                                "Hãy chắc rằng hàng hóa đã được giao nhận",
                                                                                style: TextStyle(
                                                                                  color: Colors.orangeAccent,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          confirm:
                                                                              ElevatedButton(
                                                                            style:
                                                                                ButtonStyle(
                                                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              controller.postSetRuning(
                                                                                id: controller.listDataForReceiveEmpty[i].getData![j].handlingId!,
                                                                                secondIndex: j,
                                                                              );
                                                                              // controller.toggleCompleteReceiveEmpty(j);
                                                                            },
                                                                            child:
                                                                                const Text("Xác nhận", style: TextStyle(color: Colors.white)),
                                                                          ),
                                                                          cancel:
                                                                              ElevatedButton(
                                                                            style:
                                                                                ButtonStyle(
                                                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                            child:
                                                                                const Text("Hủy", style: TextStyle(color: Colors.white)),
                                                                          ),
                                                                        );
                                                                        if (result
                                                                                is bool &&
                                                                            result ==
                                                                                true) {
                                                                          controller
                                                                              .listDataForReceiveEmpty[i]
                                                                              .getData![j];
                                                                        }
                                                                      },
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
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                  Routes
                                                                      .SUR_CHANGE_SCREEN,
                                                                  arguments: controller
                                                                      .listDataForReceiveEmpty[
                                                                          i]
                                                                      .getData![j]);
                                                            },
                                                            child: const Text(
                                                                "Phụ phí",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        ],
                                                      )
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
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                Routes
                                                                    .NOTE_PENDING_SCREEN,
                                                                arguments: controller
                                                                    .listDataForReceive[
                                                                        i]
                                                                    .getData![j]
                                                                    .handlingId,
                                                              );
                                                            },
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
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                Routes.CAMERA,
                                                                arguments: controller
                                                                    .listDataForReceive[
                                                                        i]
                                                                    .getData![j],
                                                              );
                                                            },
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
                                                                            () async {
                                                                          var result =
                                                                              await Get.toNamed(
                                                                            Routes.CANCEL_PENDING_SCREEN,
                                                                            arguments:
                                                                                controller.listDataForReceive[i].getData![j].handlingId,
                                                                          );
                                                                          if (result is bool &&
                                                                              result == true) {
                                                                            controller.listOrder.value.getDataHandlingMobiles![j].maTrangThai;
                                                                          }
                                                                        },
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
                                                                : Center(
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
                                                                            () async {
                                                                          var result =
                                                                              await Get.defaultDialog(
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                            title:
                                                                                "Thông báo",
                                                                            content:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: const [
                                                                                Text(
                                                                                  "Hãy chắc rằng hàng hóa đã được giao nhận",
                                                                                  style: TextStyle(
                                                                                    color: Colors.orangeAccent,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            confirm:
                                                                                ElevatedButton(
                                                                              style: ButtonStyle(
                                                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                                                                              ),
                                                                              onPressed: () {
                                                                                controller.postSetRuning(id: controller.listDataForReceive[i].getData![j].handlingId!, secondIndex: j);
                                                                                // controller.toggleCompleteReceive(j);
                                                                              },
                                                                              child: const Text("Xác nhận", style: TextStyle(color: Colors.white)),
                                                                            ),
                                                                            cancel:
                                                                                ElevatedButton(
                                                                              style: ButtonStyle(
                                                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                                                                              ),
                                                                              onPressed: () {
                                                                                Get.back();
                                                                              },
                                                                              child: const Text("Hủy", style: TextStyle(color: Colors.white)),
                                                                            ),
                                                                          );
                                                                          if (result is bool &&
                                                                              result == true) {
                                                                            controller.listDataForReceive[i].getData![j].maTrangThai;
                                                                          }
                                                                        },
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
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                  Routes
                                                                      .SUR_CHANGE_SCREEN,
                                                                  arguments: controller
                                                                      .listDataForReceive[
                                                                          i]
                                                                      .getData![j]);
                                                            },
                                                            child: const Text(
                                                                "Phụ phí",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        ],
                                                      )
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
                              itemCount:
                                  controller.listDataForGive.value.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  height: (180 *
                                      double.parse(controller.listDataForGive
                                          .value[i].getData!.length
                                          .toString())),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.listDataForGive.value[i]
                                                .place!,
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
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                Routes
                                                                    .NOTE_PENDING_SCREEN,
                                                                arguments: controller
                                                                    .listDataForGive[
                                                                        i]
                                                                    .getData![j]
                                                                    .handlingId,
                                                              );
                                                            },
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
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                Routes.CAMERA,
                                                                arguments: controller
                                                                    .listDataForGive[
                                                                        i]
                                                                    .getData![j],
                                                              );
                                                            },
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
                                                                          () async {
                                                                        var result =
                                                                            await Get.toNamed(
                                                                          Routes
                                                                              .CANCEL_PENDING_SCREEN,
                                                                          arguments: controller
                                                                              .listDataForGive[i]
                                                                              .getData![j]
                                                                              .handlingId,
                                                                        );
                                                                        if (result
                                                                                is bool &&
                                                                            result ==
                                                                                true) {
                                                                          controller
                                                                              .listOrder
                                                                              .value
                                                                              .getDataHandlingMobiles![j]
                                                                              .maTrangThai;
                                                                        }
                                                                      },
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
                                                                            () async {
                                                                          var result =
                                                                              await Get.defaultDialog(
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                            title:
                                                                                "Thông báo",
                                                                            content:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: const [
                                                                                Text(
                                                                                  "Hãy chắc rằng hàng hóa đã được giao nhận",
                                                                                  style: TextStyle(
                                                                                    color: Colors.orangeAccent,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            confirm:
                                                                                ElevatedButton(
                                                                              style: ButtonStyle(
                                                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                                                                              ),
                                                                              onPressed: () {
                                                                                controller.postSetRuning(id: controller.listDataForGive[i].getData![j].handlingId!, secondIndex: j);
                                                                                // controller
                                                                                //     .toggleCompleteGive(j);
                                                                              },
                                                                              child: const Text("Xác nhận", style: TextStyle(color: Colors.white)),
                                                                            ),
                                                                            cancel:
                                                                                ElevatedButton(
                                                                              style: ButtonStyle(
                                                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                                                                              ),
                                                                              onPressed: () {
                                                                                Get.back();
                                                                              },
                                                                              child: const Text("Hủy"),
                                                                            ),
                                                                          );
                                                                          if (result is bool &&
                                                                              result == true) {
                                                                            controller.listDataForGive[i].getData![j];
                                                                          }
                                                                        },
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
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                  Routes
                                                                      .SUR_CHANGE_SCREEN,
                                                                  arguments: controller
                                                                      .listDataForGive[
                                                                          i]
                                                                      .getData![j]);
                                                            },
                                                            child: const Text(
                                                                "Phụ phí",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        ],
                                                      )
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
                              itemCount:
                                  controller.listDataForGiveEmpty.value.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  height: (180 *
                                      double.parse(controller
                                          .listDataForGiveEmpty
                                          .value[i]
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
                                            controller.listDataForGiveEmpty
                                                .value[i].place!,
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
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                Routes
                                                                    .NOTE_PENDING_SCREEN,
                                                                arguments: controller
                                                                    .listDataForGiveEmpty[
                                                                        i]
                                                                    .getData![j]
                                                                    .handlingId,
                                                              );
                                                            },
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
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                Routes.CAMERA,
                                                                arguments: controller
                                                                    .listDataForGiveEmpty[
                                                                        i]
                                                                    .getData![j],
                                                              );
                                                            },
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
                                                                            .getDataHandlingMobiles![j]
                                                                            .maTrangThai ==
                                                                        35
                                                                    ? TextButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all<Color>(Colors.red),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          var result =
                                                                              await Get.toNamed(
                                                                            Routes.CANCEL_PENDING_SCREEN,
                                                                            arguments:
                                                                                controller.listDataForGiveEmpty[i].getData![j].handlingId,
                                                                          );
                                                                          if (result is bool &&
                                                                              result == true) {
                                                                            controller.listOrder.value.getDataHandlingMobiles![j].maTrangThai;
                                                                          }
                                                                        },
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
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(Colors.green),
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        var result =
                                                                            await Get.defaultDialog(
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          title:
                                                                              "Thông báo",
                                                                          titleStyle:
                                                                              const TextStyle(color: Colors.red),
                                                                          content:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: const [
                                                                              Text(
                                                                                "Hãy chắc rằng hàng hóa đã được giao nhận",
                                                                                style: TextStyle(
                                                                                  color: Colors.orangeAccent,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          confirm:
                                                                              ElevatedButton(
                                                                            style:
                                                                                ButtonStyle(
                                                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                                                Colors.orangeAccent,
                                                                              ),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              controller.postSetRuning(id: controller.listDataForGiveEmpty[i].getData![j].handlingId!, secondIndex: j);
                                                                              // controller
                                                                              //     .toggleCompleteGiveEmpty(j);
                                                                            },
                                                                            child:
                                                                                const Text(
                                                                              "Xác nhận",
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ),
                                                                          cancel:
                                                                              ElevatedButton(
                                                                            style:
                                                                                ButtonStyle(
                                                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                                                Colors.orangeAccent,
                                                                              ),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                            child:
                                                                                const Text("Hủy"),
                                                                          ),
                                                                        );
                                                                        if (result
                                                                                is bool &&
                                                                            result ==
                                                                                true) {
                                                                          controller
                                                                              .listDataForGiveEmpty[i]
                                                                              .getData![j]
                                                                              .maTrangThai;
                                                                          ;
                                                                        }
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Hoàn thành",
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
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all<
                                                                          Color>(
                                                                Colors
                                                                    .orangeAccent,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                  Routes
                                                                      .SUR_CHANGE_SCREEN,
                                                                  arguments: controller
                                                                      .listDataForGiveEmpty[
                                                                          i]
                                                                      .getData![j]);
                                                            },
                                                            child: const Text(
                                                              "Phụ phí",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      )
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
}
