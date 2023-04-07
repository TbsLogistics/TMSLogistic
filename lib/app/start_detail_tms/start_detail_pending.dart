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
        builder: (controller) {
          var length =
              controller.listOrder.value.getDataHandlingMobiles!.length;
          return SingleChildScrollView(
            child: Container(
              // height: size.height,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: controller.isLoad.value
                  ? Column(
                      children: [
                        _buttonStatus(
                            text: "Bắt đầu chuyến",
                            onPressed: () {},
                            color: Colors.black.withOpacity(0.4)),
                        _buildReciveEmpty(size),
                        _buildRecive(size),
                        _buildGive(size),
                        _buildGiveEmpty(size),
                        Obx(() => controller.isLoad.value
                            ? controller
                                        .listOrder
                                        .value
                                        .getDataHandlingMobiles![length - 1]
                                        .maTrangThai ==
                                    36
                                ? _buttonStatus(
                                    text: "Kết thúc chuyến",
                                    onPressed: () {
                                      Get.defaultDialog(
                                        backgroundColor: Colors.white,
                                        title: "Thông báo",
                                        content: Column(
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
                                        confirm: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.orangeAccent),
                                          ),
                                          onPressed: () {
                                            controller.postSetRuningTypeFull(
                                              handlingId: int.parse(
                                                controller
                                                    .listOrder
                                                    .value
                                                    .getDataHandlingMobiles![
                                                        length - 1]
                                                    .handlingId
                                                    .toString(),
                                              ),
                                            );
                                          },
                                          child: const Text("Xác nhận",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        cancel: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.orangeAccent),
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Hủy"),
                                        ),
                                      );
                                    },
                                    color: Colors.orangeAccent)
                                : _buttonStatus(
                                    text: "Kêt thúc chuyến",
                                    onPressed: () {},
                                    color: Colors.black.withOpacity(0.4),
                                  )
                            : _buttonStatus(
                                text: "Kêt thúc chuyến",
                                onPressed: () {},
                                color: Colors.black.withOpacity(0.4),
                              )),
                      ],
                    )
                  : controller.listOrder.value.getDataHandlingMobiles!.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                                "Đang tải dữ liệu vui lòng đợi trong giây lát !")
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Hết đơn , vui lòng quay lại trang trước")
                          ],
                        ),
            ),
          );
        },
      ),
    );
  }

  Widget _buttonStatus(
      {required String text,
      required VoidCallback onPressed,
      required Color color}) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReciveEmpty(Size size) {
    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.newListDataForReceiveEmpty.length,
            itemBuilder: (ctx, i) {
              return ExpandableNotifier(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: ScrollOnExpand(
                    child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
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
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "${controller.newListDataForReceiveEmpty[i].place}",
                                        style: const TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Obx(() {
                                        return controller
                                                .isPlacedReceiveEmpty[i]
                                            ? TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Colors.orangeAccent),
                                                ),
                                                onPressed: () {},
                                                child: const Text(
                                                  "Đã đến",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            : TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Colors.orangeAccent),
                                                ),
                                                onPressed: () {
                                                  controller
                                                      .updateReceiveEmpty(i);
                                                },
                                                child: const Text(
                                                  "Đến",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                      }),
                                      TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.orangeAccent),
                                        ),
                                        onPressed: () {
                                          Get.toNamed(
                                            Routes.SUR_CHANGE_SCREEN,
                                            arguments: [
                                              controller
                                                  .newListDataForReceiveEmpty[i],
                                              controller
                                                  .listOrder.value.maChuyen,
                                              controller
                                                  .newListDataForReceiveEmpty[i]
                                                  .getData![0]
                                                  .maDiemLayRong
                                            ],
                                          );
                                        },
                                        child: const Text("Phụ phí",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                            ]),
                          ),
                        ),
                        collapsed: Container(),
                        expanded: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          height: (120 *
                              double.parse(controller
                                  .newListDataForReceiveEmpty[i].getData!.length
                                  .toString())),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller
                                .newListDataForReceiveEmpty[i].getData!.length,
                            itemBuilder: (ctx, k) {
                              return Card(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    height: 110,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${controller.newListDataForReceiveEmpty[i].getData![k].maVanDon}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Obx(
                                              () => controller
                                                      .isLoadStatus.value
                                                  ? controller
                                                              .newListDataForReceiveEmpty[
                                                                  i]
                                                              .getData![k]
                                                              .maTrangThai !=
                                                          17
                                                      ? const Text(
                                                          "Đã lấy rỗng",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        )
                                                      : controller
                                                              .isPlacedReceive[i]
                                                          ? Text(
                                                              "${controller.newListDataForReceiveEmpty[i].getData![k].trangThai}",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                          : const Text(
                                                              "Đang lấy rỗng",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                  : Container(),
                                            ),
                                            TextButton.icon(
                                              onPressed: () {
                                                Get.toNamed(
                                                  Routes.NOTE_PENDING_SCREEN,
                                                  arguments: controller
                                                      .newListDataForReceiveEmpty[
                                                          i]
                                                      .getData![k]
                                                      .handlingId,
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.edit_note_outlined,
                                                  color: Colors.orangeAccent),
                                              label: const Text(
                                                "Ghi chú",
                                                style: TextStyle(
                                                    color: Colors.orangeAccent),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.orangeAccent),
                                              ),
                                              onPressed: () {
                                                Get.toNamed(
                                                  Routes.CAMERA,
                                                  arguments: controller
                                                      .newListDataForReceiveEmpty[
                                                          i]
                                                      .getData![k],
                                                );
                                              },
                                              child: const Text("Chứng từ",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            Obx(() => controller
                                                    .isLoadStatus.value
                                                ? controller
                                                            .newListDataForReceiveEmpty[
                                                                i]
                                                            .getData![k]
                                                            .maTrangThai ==
                                                        17
                                                    ? TextButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      Colors
                                                                          .red),
                                                        ),
                                                        onPressed: () {
                                                          _cancelButton(
                                                            size: size,
                                                            onPressed:
                                                                () async {
                                                              if (controller
                                                                  .formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                controller.postCancel(
                                                                    idList:
                                                                        "lr",
                                                                    firstIndex:
                                                                        i,
                                                                    id: controller
                                                                        .newListDataForReceiveEmpty[
                                                                            i]
                                                                        .getData![
                                                                            k]
                                                                        .handlingId!,
                                                                    secondsIndex:
                                                                        k);
                                                              }
                                                            },
                                                          );
                                                        },
                                                        child: const Text(
                                                            "Hủy hoàn thành",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      )
                                                    : TextButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.4)),
                                                        ),
                                                        onPressed: () {},
                                                        child: const Text(
                                                            "Hủy hoàn thành",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      )
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color:
                                                          Colors.orangeAccent,
                                                    ),
                                                  )),
                                            Obx(() {
                                              return controller
                                                      .isLoadStatus.value
                                                  ? controller
                                                              .newListDataForReceiveEmpty[
                                                                  i]
                                                              .getData![k]
                                                              .maTrangThai ==
                                                          17
                                                      ? TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .green),
                                                          ),
                                                          onPressed: () async {
                                                            var result = await Get
                                                                .defaultDialog(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              title:
                                                                  "Thông báo",
                                                              content: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Text(
                                                                    "Hãy chắc rằng hàng hóa đã được giao nhận",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .orangeAccent,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              confirm:
                                                                  ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .orangeAccent),
                                                                ),
                                                                onPressed: () {
                                                                  // controller
                                                                  //     .loadData();
                                                                  controller.postSetRuning(
                                                                      idList:
                                                                          "lr",
                                                                      firstIndex:
                                                                          i,
                                                                      id: controller
                                                                          .newListDataForReceiveEmpty[
                                                                              i]
                                                                          .getData![
                                                                              k]
                                                                          .handlingId!,
                                                                      secondIndex:
                                                                          k);
                                                                },
                                                                child: const Text(
                                                                    "Xác nhận",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                              cancel:
                                                                  ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .orangeAccent),
                                                                ),
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "Hủy"),
                                                              ),
                                                            );
                                                            if (result
                                                                    is bool &&
                                                                result ==
                                                                    true) {
                                                              controller
                                                                  .newListDataForReceiveEmpty[
                                                                      i]
                                                                  .getData![k];
                                                            }
                                                          },
                                                          child: const Text(
                                                              "Hoàn thành",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        )
                                                      : TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty.all<
                                                                        Color>(
                                                                    Colors.black
                                                                        .withOpacity(
                                                                            0.4)),
                                                          ),
                                                          onPressed: () {},
                                                          child: const Text(
                                                              "Hoàn thành",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)))
                                                  : const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            Colors.orangeAccent,
                                                      ),
                                                    );
                                            })
                                          ],
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ));
            }),
      ],
    );
  }

  Widget _buildRecive(Size size) {
    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.newListDataForReceive.length,
            itemBuilder: (ctx, i) {
              return ExpandableNotifier(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: ScrollOnExpand(
                    child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
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
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${controller.newListDataForReceive[i].place}",
                                    style: const TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 18),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Obx(() => controller.isPlacedReceive[i]
                                          ? TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.orangeAccent),
                                              ),
                                              onPressed: () {},
                                              child: const Text(
                                                "Đã đến",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          : TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.orangeAccent),
                                              ),
                                              onPressed: () {
                                                print("Recrive$i");
                                                controller.updateReceive(i);
                                              },
                                              child: const Text(
                                                "Đến",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.orangeAccent),
                                        ),
                                        onPressed: () {
                                          Get.toNamed(
                                            Routes.SUR_CHANGE_SCREEN,
                                            arguments: [
                                              controller
                                                  .newListDataForReceive[i],
                                              controller
                                                  .listOrder.value.maChuyen,
                                              controller
                                                  .newListDataForReceive[i]
                                                  .getData![0]
                                                  .maDiemLayHang
                                            ],
                                          );
                                        },
                                        child: const Text("Phụ phí",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                            ]),
                          ),
                        ),
                        collapsed: Container(),
                        expanded: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          height: (120 *
                              double.parse(controller
                                  .newListDataForReceive[i].getData!.length
                                  .toString())),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller
                                .newListDataForReceive[i].getData!.length,
                            itemBuilder: (ctx, k) {
                              return Card(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    height: 110,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${controller.newListDataForReceive[i].getData![k].maVanDon}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Obx(
                                              () => controller
                                                      .isLoadStatus.value
                                                  ? controller
                                                                  .newListDataForReceive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai !=
                                                              34 &&
                                                          controller
                                                                  .newListDataForReceive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai !=
                                                              40
                                                      ? const Text(
                                                          "Đã lấy hàng",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        )
                                                      : controller
                                                              .isPlacedReceive[i]
                                                          ? Text(
                                                              "${controller.newListDataForReceive[i].getData![k].trangThai}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                          : const Text(
                                                              "Đang đi lấy hàng",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                  : Container(),
                                            ),
                                            TextButton.icon(
                                              onPressed: () {
                                                Get.toNamed(
                                                  Routes.NOTE_PENDING_SCREEN,
                                                  arguments: controller
                                                      .newListDataForReceive[i]
                                                      .getData![k]
                                                      .handlingId,
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.edit_note_outlined,
                                                  color: Colors.orangeAccent),
                                              label: const Text(
                                                "Ghi chú",
                                                style: TextStyle(
                                                    color: Colors.orangeAccent),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.orangeAccent),
                                              ),
                                              onPressed: () {
                                                Get.toNamed(
                                                  Routes.CAMERA,
                                                  arguments: controller
                                                      .newListDataForReceive[i]
                                                      .getData![k],
                                                );
                                              },
                                              child: const Text("Chứng từ",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            Obx(() => controller
                                                    .isLoadStatus.value
                                                ? controller
                                                                .newListDataForReceive[
                                                                    i]
                                                                .getData![k]
                                                                .maTrangThai ==
                                                            37 ||
                                                        controller
                                                                .newListDataForReceive[
                                                                    i]
                                                                .getData![k]
                                                                .maTrangThai ==
                                                            40
                                                    ? TextButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      Colors
                                                                          .red),
                                                        ),
                                                        onPressed: () {
                                                          _cancelButton(
                                                            size: size,
                                                            onPressed: () {
                                                              if (controller
                                                                  .formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                controller.postCancel(
                                                                    idList:
                                                                        "lh",
                                                                    firstIndex:
                                                                        i,
                                                                    id: controller
                                                                        .newListDataForReceive[
                                                                            i]
                                                                        .getData![
                                                                            k]
                                                                        .handlingId!,
                                                                    secondsIndex:
                                                                        k);
                                                              }
                                                            },
                                                          );
                                                        },
                                                        child: const Text(
                                                            "Hủy hoàn thành",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      )
                                                    : TextButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.4)),
                                                        ),
                                                        onPressed: () {},
                                                        child: const Text(
                                                            "Hủy hoàn thành",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      )
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color:
                                                          Colors.orangeAccent,
                                                    ),
                                                  )),
                                            Obx(() {
                                              return controller
                                                      .isLoadStatus.value
                                                  ? controller
                                                                  .newListDataForReceive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai ==
                                                              37 ||
                                                          controller
                                                                  .newListDataForReceive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai ==
                                                              40
                                                      ? TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .green),
                                                          ),
                                                          onPressed: () async {
                                                            var result = await Get
                                                                .defaultDialog(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              title:
                                                                  "Thông báo",
                                                              content: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Text(
                                                                    "Hãy chắc rằng hàng hóa đã được giao nhận",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .orangeAccent,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              confirm:
                                                                  ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .orangeAccent),
                                                                ),
                                                                onPressed: () {
                                                                  controller.postSetRuning(
                                                                      idList:
                                                                          "lh",
                                                                      firstIndex:
                                                                          i,
                                                                      id: controller
                                                                          .newListDataForReceive[
                                                                              i]
                                                                          .getData![
                                                                              k]
                                                                          .handlingId!,
                                                                      secondIndex:
                                                                          k);
                                                                },
                                                                child: const Text(
                                                                    "Xác nhận",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                              cancel:
                                                                  ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .orangeAccent),
                                                                ),
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "Hủy"),
                                                              ),
                                                            );
                                                            if (result
                                                                    is bool &&
                                                                result ==
                                                                    true) {
                                                              controller
                                                                  .newListDataForReceive[
                                                                      i]
                                                                  .getData![k];
                                                            }
                                                          },
                                                          child: const Text(
                                                              "Hoàn thành",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        )
                                                      : TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty.all<
                                                                        Color>(
                                                                    Colors.black
                                                                        .withOpacity(
                                                                            0.4)),
                                                          ),
                                                          onPressed: () {},
                                                          child: const Text(
                                                              "Hoàn thành",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)))
                                                  : const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            Colors.orangeAccent,
                                                      ),
                                                    );
                                            })
                                          ],
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ));
            })
      ],
    );
  }

  Widget _buildGive(Size size) {
    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.newListDataForGive.length,
            itemBuilder: (ctx, i) {
              return ExpandableNotifier(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: ScrollOnExpand(
                    child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
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
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${controller.newListDataForGive[i].place}",
                                    style: const TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 18),
                                  ),
                                  Column(
                                    children: [
                                      Obx(() => controller.isPlacedGive[i]
                                          ? TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.orangeAccent),
                                              ),
                                              onPressed: () {
                                                print("Give$i");
                                                // controller.updateReceive(i);
                                              },
                                              child: const Text(
                                                "Đã đến",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          : TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.orangeAccent),
                                              ),
                                              onPressed: () {
                                                print("Give$i");
                                                controller.updateGive(i);
                                              },
                                              child: const Text(
                                                "Đến",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.orangeAccent),
                                        ),
                                        onPressed: () {
                                          Get.toNamed(
                                            Routes.SUR_CHANGE_SCREEN,
                                            arguments: [
                                              controller.newListDataForGive[i],
                                              controller
                                                  .listOrder.value.maChuyen,
                                              controller.newListDataForGive[i]
                                                  .getData![0].maDiemTraHang
                                            ],
                                          );
                                        },
                                        child: const Text("Phụ phí",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                            ]),
                          ),
                        ),
                        collapsed: Container(),
                        expanded: Container(
                          height: (120 *
                              double.parse(controller
                                  .newListDataForGive[i].getData!.length
                                  .toString())),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller
                                .newListDataForGive[i].getData!.length,
                            itemBuilder: (ctx, k) {
                              return Card(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    height: 110,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${controller.newListDataForGive[i].getData![k].maVanDon}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Obx(
                                              () => controller
                                                      .isLoadStatus.value
                                                  ? controller
                                                                  .newListDataForGive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai !=
                                                              18 &&
                                                          controller
                                                                  .newListDataForGive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai !=
                                                              37 &&
                                                          controller
                                                                  .newListDataForGive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai !=
                                                              40 &&
                                                          controller
                                                                  .newListDataForGive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai !=
                                                              17
                                                      ? const Text(
                                                          "Đã giao hàng",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        )
                                                      : controller
                                                              .isPlacedGive[i]
                                                          ? Text(
                                                              "${controller.newListDataForGive[i].getData![k].trangThai}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                          : const Text(
                                                              "Đang đi giao hàng",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                  : Container(),
                                            ),
                                            TextButton.icon(
                                              onPressed: () {
                                                Get.toNamed(
                                                  Routes.NOTE_PENDING_SCREEN,
                                                  arguments: controller
                                                      .newListDataForGive[i]
                                                      .getData![k]
                                                      .handlingId,
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.edit_note_outlined,
                                                  color: Colors.orangeAccent),
                                              label: const Text(
                                                "Ghi chú",
                                                style: TextStyle(
                                                    color: Colors.orangeAccent),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.orangeAccent),
                                              ),
                                              onPressed: () {
                                                Get.toNamed(
                                                  Routes.CAMERA,
                                                  arguments: controller
                                                      .newListDataForGive[i]
                                                      .getData![k],
                                                );
                                              },
                                              child: const Text("Chứng từ",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            Obx(() => controller
                                                    .isLoadStatus.value
                                                ? controller
                                                                .newListDataForGive[
                                                                    i]
                                                                .getData![k]
                                                                .maTrangThai ==
                                                            18 &&
                                                        controller
                                                                .newListDataForGive[
                                                                    i]
                                                                .getData![k]
                                                                .maTrangThai !=
                                                            43
                                                    ? TextButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      Colors
                                                                          .red),
                                                        ),
                                                        onPressed: () {
                                                          _cancelButton(
                                                            size: size,
                                                            onPressed: () {
                                                              if (controller
                                                                  .formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                controller.postCancel(
                                                                    idList:
                                                                        "lh",
                                                                    firstIndex:
                                                                        i,
                                                                    id: controller
                                                                        .newListDataForGive[
                                                                            i]
                                                                        .getData![
                                                                            k]
                                                                        .handlingId!,
                                                                    secondsIndex:
                                                                        k);
                                                              }
                                                            },
                                                          );
                                                        },
                                                        child: const Text(
                                                            "Hủy hoàn thành",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      )
                                                    : TextButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.4)),
                                                        ),
                                                        onPressed: () {},
                                                        child: const Text(
                                                            "Hủy hoàn thành",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      )
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color:
                                                          Colors.orangeAccent,
                                                    ),
                                                  )),
                                            Obx(() {
                                              return controller
                                                      .isLoadStatus.value
                                                  ? controller
                                                                  .newListDataForGive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai ==
                                                              18 &&
                                                          controller
                                                                  .newListDataForGive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai !=
                                                              43
                                                      ? TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .green),
                                                          ),
                                                          onPressed: () async {
                                                            var result = await Get
                                                                .defaultDialog(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              title:
                                                                  "Thông báo",
                                                              content: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Text(
                                                                    "Hãy chắc rằng hàng hóa đã được giao nhận",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .orangeAccent,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              confirm:
                                                                  ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .orangeAccent),
                                                                ),
                                                                onPressed: () {
                                                                  controller.postSetRuning(
                                                                      idList:
                                                                          "th",
                                                                      firstIndex:
                                                                          i,
                                                                      id: controller
                                                                          .newListDataForGive[
                                                                              i]
                                                                          .getData![
                                                                              k]
                                                                          .handlingId!,
                                                                      secondIndex:
                                                                          k);

                                                                  // controller
                                                                  //     .toggleCompleteGive(k);
                                                                },
                                                                child: const Text(
                                                                    "Xác nhận",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                              cancel:
                                                                  ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .orangeAccent),
                                                                ),
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "Hủy"),
                                                              ),
                                                            );
                                                            if (result
                                                                    is bool &&
                                                                result ==
                                                                    true) {
                                                              controller
                                                                  .newListDataForGive[
                                                                      i]
                                                                  .getData![k];
                                                            }
                                                          },
                                                          child: const Text(
                                                              "Hoàn thành",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        )
                                                      : TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty.all<
                                                                        Color>(
                                                                    Colors.black
                                                                        .withOpacity(
                                                                            0.4)),
                                                          ),
                                                          onPressed: () {
                                                            print(controller
                                                                .newListDataForGive[
                                                                    i]
                                                                .getData![k]
                                                                .maTrangThai);
                                                          },
                                                          child: const Text(
                                                              "Hoàn thành",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)))
                                                  : const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            Colors.orangeAccent,
                                                      ),
                                                    );
                                            })
                                          ],
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ));
            })
      ],
    );
  }

  Widget _buildGiveEmpty(Size size) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: controller.newListDataForGiveEmpty.length,
        itemBuilder: (ctx, i) {
          return ExpandableNotifier(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: ScrollOnExpand(
                child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
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
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.newListDataForGiveEmpty[i].place}",
                                  style: const TextStyle(
                                      color: Colors.orangeAccent, fontSize: 18),
                                ),
                                Column(
                                  children: [
                                    Obx(() {
                                      return controller.isPlacedGiveEmpty[i]
                                          ? TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.orangeAccent),
                                              ),
                                              onPressed: () {},
                                              child: const Text(
                                                "Đã đến",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          : TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.orangeAccent),
                                              ),
                                              onPressed: () {
                                                controller.updateGiveEmpty(i);
                                              },
                                              child: const Text(
                                                "Đến",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );
                                    }),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.orangeAccent),
                                      ),
                                      onPressed: () {
                                        Get.toNamed(Routes.SUR_CHANGE_SCREEN,
                                            arguments: [
                                              controller
                                                  .newListDataForGiveEmpty[i],
                                              controller
                                                  .listOrder.value.maChuyen,
                                              controller
                                                  .newListDataForGiveEmpty[i]
                                                  .getData![0]
                                                  .maDiemTraRong
                                            ]);
                                      },
                                      child: const Text("Phụ phí",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                    collapsed: Container(
                      color: Colors.amberAccent,
                    ),
                    expanded: Container(
                      height: (120 *
                          double.parse(controller
                              .newListDataForGiveEmpty[i].getData!.length
                              .toString())),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller
                            .newListDataForGiveEmpty[i].getData!.length,
                        itemBuilder: (ctx, k) {
                          return Card(
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                height: 110,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${controller.newListDataForGiveEmpty[i].getData![k].maVanDon}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Obx(
                                          () => controller
                                                          .newListDataForGiveEmpty[
                                                              i]
                                                          .getData![k]
                                                          .maTrangThai ==
                                                      35 ||
                                                  controller
                                                          .newListDataForGiveEmpty[
                                                              i]
                                                          .getData![k]
                                                          .maTrangThai ==
                                                      36
                                              ? const Text(
                                                  "Đã trả rỗng",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                )
                                              : controller.isPlacedGiveEmpty[i]
                                                  ? const Text(
                                                      "Đang trả rỗng",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    )
                                                  : const Text(
                                                      "Đang đi trả rỗng",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                            Get.toNamed(
                                                Routes.NOTE_PENDING_SCREEN,
                                                arguments: [
                                                  controller
                                                      .newListDataForGiveEmpty[
                                                          i]
                                                      .getData![k]
                                                      .handlingId,
                                                  "lr"
                                                ]);
                                          },
                                          icon: const Icon(
                                              Icons.edit_note_outlined,
                                              color: Colors.orangeAccent),
                                          label: const Text(
                                            "Ghi chú",
                                            style: TextStyle(
                                                color: Colors.orangeAccent),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.orangeAccent),
                                          ),
                                          onPressed: () {
                                            Get.toNamed(
                                              Routes.CAMERA,
                                              arguments: controller
                                                  .newListDataForGiveEmpty[i]
                                                  .getData![k],
                                            );
                                          },
                                          child: const Text("Chứng từ",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        Obx(() => controller.isLoadStatus.value
                                            ? controller
                                                        .newListDataForGiveEmpty[
                                                            i]
                                                        .getData![k]
                                                        .maTrangThai ==
                                                    35
                                                ? TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.red),
                                                    ),
                                                    onPressed: () {
                                                      _cancelButton(
                                                        size: size,
                                                        onPressed: () {
                                                          if (controller.formKey
                                                              .currentState!
                                                              .validate()) {
                                                            controller.postCancel(
                                                                idList: "tr",
                                                                firstIndex: i,
                                                                id: controller
                                                                    .newListDataForGiveEmpty[
                                                                        i]
                                                                    .getData![k]
                                                                    .handlingId!,
                                                                secondsIndex:
                                                                    k);
                                                          }
                                                        },
                                                      );
                                                    },
                                                    child: const Text(
                                                        "Hủy hoàn thành",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  )
                                                : TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4)),
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text(
                                                        "Hủy hoàn thành",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.orangeAccent,
                                                ),
                                              )),
                                        Obx(() {
                                          return controller.isLoadStatus.value
                                              ? controller
                                                          .newListDataForGiveEmpty[
                                                              i]
                                                          .getData![k]
                                                          .maTrangThai ==
                                                      35
                                                  ? TextButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .green),
                                                      ),
                                                      onPressed: () async {
                                                        var result = await Get
                                                            .defaultDialog(
                                                          backgroundColor:
                                                              Colors.white,
                                                          title: "Thông báo",
                                                          content: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              Text(
                                                                "Hãy chắc rằng hàng hóa đã được giao nhận",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .orangeAccent,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          confirm:
                                                              ElevatedButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .orangeAccent),
                                                            ),
                                                            onPressed: () {
                                                              controller.postSetRuning(
                                                                  idList: "tr",
                                                                  firstIndex: i,
                                                                  id: controller
                                                                      .newListDataForGiveEmpty[
                                                                          i]
                                                                      .getData![
                                                                          k]
                                                                      .handlingId!,
                                                                  secondIndex:
                                                                      k);

                                                              // controller
                                                              //     .toggleCompleteGive(k);
                                                            },
                                                            child: const Text(
                                                                "Xác nhận",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                          cancel:
                                                              ElevatedButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .orangeAccent),
                                                            ),
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child: const Text(
                                                                "Hủy"),
                                                          ),
                                                        );
                                                        if (result is bool &&
                                                            result == true) {
                                                          controller
                                                              .newListDataForGiveEmpty[
                                                                  i]
                                                              .getData![k];
                                                        }
                                                      },
                                                      child: const Text(
                                                          "Hoàn thành",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    )
                                                  : TextButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.4)),
                                                      ),
                                                      onPressed: () {},
                                                      child: const Text(
                                                          "Hoàn thành",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)))
                                              : const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.orangeAccent,
                                                  ),
                                                );
                                        })
                                      ],
                                    ),
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ));
        });
  }

  _cancelButton({required Size size, required VoidCallback onPressed}) {
    return Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "Thông báo",
      titleStyle: const TextStyle(
        color: Colors.red,
      ),
      content: SizedBox(
        height: 150,
        width: size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hãy chắc rằng muốn hủy đơn hàng",
              style: TextStyle(
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: controller.formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  validator: (value) => value == null || value == ""
                      ? "Nhập lý do hủy đơn hàng"
                      : null,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  maxLines: 3,
                  controller: controller.cancelController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(.0),
                      borderSide: const BorderSide(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    hintText: "Nhập lý do hủy đơn",
                    contentPadding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 20,
                      bottom: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      confirm: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.orangeAccent),
        ),
        onPressed: onPressed,
        child: const Text("Xác nhận", style: TextStyle(color: Colors.white)),
      ),
      cancel: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.orangeAccent),
        ),
        onPressed: () {
          Get.back();
        },
        child: const Text("Hủy"),
      ),
    );
  }
}
