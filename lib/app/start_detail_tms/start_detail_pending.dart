import "dart:math" as math;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:tbs_logistics_tms/app/start_detail_tms/controller/start_detail_pending_controller.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/widgets/button_success.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/widgets/text_success.dart';
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
          print(length);
          return SingleChildScrollView(
            child: Obx(
              () => Container(
                // height: size.height,
                width: size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                          Obx(() {
                            print(controller
                                .listOrder
                                .value
                                .getDataHandlingMobiles![length - 1]
                                .maTrangThai);
                            return controller
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
                                              TextCustomComment(
                                                  text:
                                                      "Hãy chắc rằng hàng hóa đã được giao nhận")
                                            ],
                                          ),
                                          confirm: Obx(() => controller
                                                  .isLoading.value
                                              ? const CircularProgressIndicator(
                                                  color: Colors.orangeAccent,
                                                )
                                              : ButtonComment(
                                                  text: "Kết thúc chuyến",
                                                  onPressed: () {
                                                    controller
                                                        .postSetRuningTypeFull(
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
                                                  })),
                                          cancel: ButtonComment(
                                              text: "Hủy",
                                              onPressed: () {
                                                Get.back();
                                              }));
                                    },
                                    color: Colors.orangeAccent)
                                : _buttonStatus(
                                    text: "Kêt thúc chuyến",
                                    onPressed: () {},
                                    color: Colors.black.withOpacity(0.4),
                                  );
                          }),
                        ],
                      )
                    : controller
                            .listOrder.value.getDataHandlingMobiles!.isNotEmpty
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
            ),
          );
        },
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
                                            ? ButtonComment(
                                                text: "Đã đến",
                                                onPressed: () {},
                                              )
                                            : ButtonComment(
                                                text: "Đến",
                                                onPressed: () {
                                                  controller.updateReceiveEmpty(
                                                    index: i,
                                                    placeId: int.parse(
                                                      controller
                                                          .listOrder
                                                          .value
                                                          .getDataHandlingMobiles![
                                                              0]
                                                          .maDiemLayRong
                                                          .toString(),
                                                    ),
                                                  );
                                                },
                                              );
                                      }),
                                      ButtonComment(
                                          text: "Phụ phí",
                                          onPressed: () {
                                            Get.toNamed(
                                              Routes.SUR_CHANGE_SCREEN,
                                              arguments: [
                                                controller
                                                    .newListDataForReceiveEmpty[i],
                                                controller
                                                    .listOrder.value.maChuyen,
                                                controller
                                                    .newListDataForReceiveEmpty[
                                                        i]
                                                    .getData![0]
                                                    .maDiemLayRong
                                              ],
                                            );
                                          }),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            () => controller.isLoadStatus.value
                                                ? controller
                                                        .isPlacedReceiveEmpty[i]
                                                    ? controller
                                                                .newListDataForReceiveEmpty[
                                                                    i]
                                                                .getData![k]
                                                                .maTrangThai ==
                                                            17
                                                        ? const TextCustom(
                                                            text:
                                                                "Đang lấy rỗng")
                                                        : const TextCustom(
                                                            text: "Đã lấy rỗng")
                                                    : const Text("")
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
                                            label: const TextCustomComment(
                                                text: "Ghi chú"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ButtonComment(
                                            text: "Chứng từ",
                                            onPressed: () {
                                              Get.toNamed(Routes.CAMERA,
                                                  arguments: [
                                                    controller
                                                        .newListDataForReceiveEmpty[
                                                            i]
                                                        .getData![k],
                                                    controller
                                                        .newListDataForReceiveEmpty[
                                                            i]
                                                        .getData![k]
                                                        .maDiemLayRong
                                                  ]);
                                            },
                                          ),
                                          Obx(
                                            () => controller
                                                    .isPlacedReceiveEmpty[i]
                                                ? controller.isLoadStatus.value
                                                    ? controller
                                                                .newListDataForReceiveEmpty[
                                                                    i]
                                                                .getData![k]
                                                                .maTrangThai ==
                                                            17
                                                        ? ButtonError(
                                                            text:
                                                                "Hủy hoàn thành",
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
                                                            })
                                                        : ButtonFinal(
                                                            text:
                                                                "Hủy hoàn thành",
                                                            onPressed: () {},
                                                          )
                                                    : ButtonFinal(
                                                        text: "",
                                                        onPressed: () {},
                                                      )
                                                : ButtonFinal(
                                                    text: "Hủy hoàn thành",
                                                    onPressed: () {},
                                                  ),
                                          ),
                                          Obx(() {
                                            return controller
                                                    .isPlacedReceiveEmpty[i]
                                                ? controller.isLoadStatus.value
                                                    ? controller
                                                                .newListDataForReceiveEmpty[
                                                                    i]
                                                                .getData![k]
                                                                .maTrangThai ==
                                                            17
                                                        ? ButtonSuccess(
                                                            text: "Hoàn thành",
                                                            onPressed: () {
                                                              Get.defaultDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
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
                                                                confirm: Obx(
                                                                  () => controller
                                                                          .isLoading
                                                                          .value
                                                                      ? const CircularProgressIndicator(
                                                                          color:
                                                                              Colors.orangeAccent,
                                                                        )
                                                                      : ElevaButtonSuccess(
                                                                          text:
                                                                              "Xác nhận",
                                                                          onPressed:
                                                                              () {
                                                                            controller.postSetRuning(
                                                                              idList: "lr",
                                                                              firstIndex: i,
                                                                              id: controller.newListDataForReceiveEmpty[i].getData![k].handlingId!,
                                                                              secondIndex: k,
                                                                            );
                                                                          },
                                                                        ),
                                                                ),
                                                                cancel:
                                                                    ElevaButtonSuccess(
                                                                        text:
                                                                            "Hủy",
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                        }),
                                                              );
                                                            })
                                                        : ButtonFinal(
                                                            text: "Hoàn thành",
                                                            onPressed: () {})
                                                    : ButtonFinal(
                                                        text: "Hoàn thành",
                                                        onPressed: () {})
                                                : ButtonFinal(
                                                    text: "Hoàn thành",
                                                    onPressed: () {});
                                          })
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
                                  Column(
                                    children: [
                                      Text(
                                        controller
                                            .newListDataForReceive[i].place!
                                            .trim(),
                                        style: const TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Obx(() => controller.isPlacedReceive[i]
                                          ? ButtonComment(
                                              text: "Đã đến", onPressed: () {})
                                          : ButtonComment(
                                              text: "Đến",
                                              onPressed: () {
                                                controller.updateReceive(
                                                  index: i,
                                                  placeId: int.parse(
                                                    controller
                                                        .listOrder
                                                        .value
                                                        .getDataHandlingMobiles![
                                                            0]
                                                        .maDiemLayHang
                                                        .toString(),
                                                  ),
                                                );
                                              })),
                                      ButtonComment(
                                          text: "Phụ phí",
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
                                          })
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
                                                          .isPlacedReceive[i]
                                                      ? controller
                                                                      .newListDataForReceive[
                                                                          i]
                                                                      .getData![
                                                                          k]
                                                                      .maTrangThai ==
                                                                  37 ||
                                                              controller
                                                                      .newListDataForReceive[
                                                                          i]
                                                                      .getData![
                                                                          k]
                                                                      .maTrangThai ==
                                                                  40
                                                          ? const TextCustom(
                                                              text:
                                                                  "Đang lấy hàng")
                                                          : const TextCustom(
                                                              text:
                                                                  "Đã lấy hàng")
                                                      : const Text("")
                                                  : Container(),
                                            ),
                                            TextButton.icon(
                                                onPressed: () {
                                                  Get.toNamed(
                                                    Routes.NOTE_PENDING_SCREEN,
                                                    arguments: controller
                                                        .newListDataForReceive[
                                                            i]
                                                        .getData![k]
                                                        .handlingId,
                                                  );
                                                },
                                                icon: const Icon(
                                                    Icons.edit_note_outlined,
                                                    color: Colors.orangeAccent),
                                                label: const TextCustom(
                                                  text: "Ghi chú",
                                                )),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ButtonComment(
                                                text: "Chứng từ",
                                                onPressed: () {
                                                  Get.toNamed(
                                                    Routes.CAMERA,
                                                    arguments: [
                                                      controller
                                                          .newListDataForReceive[
                                                              i]
                                                          .getData![k],
                                                      controller
                                                          .newListDataForReceive[
                                                              i]
                                                          .getData![k]
                                                          .maDiemLayHang,
                                                    ],
                                                  );
                                                }),
                                            Obx(() => controller
                                                    .isPlacedReceive[i]
                                                ? controller.isLoadStatus.value
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
                                                        ? ButtonError(
                                                            text:
                                                                "Hủy hoàn thành",
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
                                                            })
                                                        : ButtonFinal(
                                                            text:
                                                                "Hủy hoàn thành",
                                                            onPressed: () {},
                                                          )
                                                    : ButtonFinal(
                                                        text: "",
                                                        onPressed: () {},
                                                      )
                                                : ButtonFinal(
                                                    text: "Hủy hoàn thành",
                                                    onPressed: () {},
                                                  )),
                                            Obx(() {
                                              return controller
                                                      .isPlacedReceive[i]
                                                  ? controller
                                                          .isLoadStatus.value
                                                      ? controller
                                                                      .newListDataForReceive[
                                                                          i]
                                                                      .getData![
                                                                          k]
                                                                      .maTrangThai ==
                                                                  37 ||
                                                              controller
                                                                      .newListDataForReceive[
                                                                          i]
                                                                      .getData![
                                                                          k]
                                                                      .maTrangThai ==
                                                                  40
                                                          ? ButtonSuccess(
                                                              text:
                                                                  "Hoàn thành",
                                                              onPressed: () {
                                                                Get.defaultDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  title:
                                                                      "Thông báo",
                                                                  content:
                                                                      Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: const [
                                                                      Text(
                                                                        "Hãy chắc rằng hàng hóa đã được giao nhận",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.orangeAccent,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  confirm: controller
                                                                          .isLoading
                                                                          .value
                                                                      ? const CircularProgressIndicator(
                                                                          color:
                                                                              Colors.orangeAccent,
                                                                        )
                                                                      : ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            backgroundColor:
                                                                                MaterialStateProperty.all<Color>(Colors.orangeAccent),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            controller.postSetRuning(
                                                                                idList: "lh",
                                                                                firstIndex: i,
                                                                                id: controller.newListDataForReceive[i].getData![k].handlingId!,
                                                                                secondIndex: k);
                                                                          },
                                                                          child: const Text(
                                                                              "Xác nhận",
                                                                              style: TextStyle(color: Colors.white)),
                                                                        ),
                                                                  cancel:
                                                                      ElevatedButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .orangeAccent),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    },
                                                                    child: const Text(
                                                                        "Hủy"),
                                                                  ),
                                                                );
                                                              })
                                                          : ButtonFinal(
                                                              text:
                                                                  "Hoàn thành",
                                                              onPressed: () {})
                                                      : ButtonFinal(
                                                          text: "",
                                                          onPressed: () {})
                                                  : ButtonFinal(
                                                      text: "Hoàn thành",
                                                      onPressed: () {});
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
                                          ? ButtonComment(
                                              text: "Đã đến", onPressed: () {})
                                          : ButtonComment(
                                              text: "Đến",
                                              onPressed: () {
                                                controller.updateGive(
                                                  index: i,
                                                  placeId: int.parse(
                                                    controller
                                                        .listOrder
                                                        .value
                                                        .getDataHandlingMobiles![
                                                            0]
                                                        .maDiemTraHang
                                                        .toString(),
                                                  ),
                                                );
                                              })),
                                      ButtonComment(
                                          text: "Phụ phí",
                                          onPressed: () {
                                            Get.toNamed(
                                              Routes.SUR_CHANGE_SCREEN,
                                              arguments: [
                                                controller
                                                    .newListDataForGive[i],
                                                controller
                                                    .listOrder.value.maChuyen,
                                                controller.newListDataForGive[i]
                                                    .getData![0].maDiemTraHang
                                              ],
                                            );
                                          })
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
                                                  ? controller.isPlacedGive[i]
                                                      ? controller
                                                                  .newListDataForGive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai ==
                                                              18
                                                          ? const TextCustom(
                                                              text:
                                                                  "Đang giao hàng")
                                                          : const TextCustom(
                                                              text:
                                                                  "Đã giao hàng")
                                                      : const Text("")
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
                                                label: const TextCustom(
                                                    text: "Ghi chú")),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ButtonComment(
                                                text: "Chứng từ",
                                                onPressed: () {
                                                  Get.toNamed(Routes.CAMERA,
                                                      arguments: [
                                                        controller
                                                            .newListDataForGive[
                                                                i]
                                                            .getData![k],
                                                        controller
                                                            .newListDataForGive[
                                                                i]
                                                            .getData![k]
                                                            .maDiemLayHang
                                                      ]);
                                                }),
                                            Obx(() => controller.isPlacedGive[i]
                                                ? controller.isLoadStatus.value
                                                    ? controller
                                                                .newListDataForGive[
                                                                    i]
                                                                .getData![k]
                                                                .maTrangThai ==
                                                            18
                                                        ? ButtonComment(
                                                            text:
                                                                "Hủy hoàn thành",
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
                                                            })
                                                        : ButtonFinal(
                                                            text:
                                                                "Hủy hoàn thành",
                                                            onPressed: () {})
                                                    : ButtonFinal(
                                                        text: "",
                                                        onPressed: () {})
                                                : ButtonFinal(
                                                    text: "Hủy hoàn thành",
                                                    onPressed: () {})),
                                            Obx(() {
                                              return controller.isPlacedGive[i]
                                                  ? controller
                                                          .isLoadStatus.value
                                                      ? controller
                                                                  .newListDataForGive[
                                                                      i]
                                                                  .getData![k]
                                                                  .maTrangThai ==
                                                              18
                                                          ? ButtonSuccess(
                                                              text:
                                                                  "Hoàn thành",
                                                              onPressed: () {
                                                                Get.defaultDialog(
                                                                    backgroundColor: Colors.white,
                                                                    title: "Thông báo",
                                                                    content: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: const [
                                                                        TextCustomComment(
                                                                            text:
                                                                                "Hãy chắc rằng hàng hóa đã được giao nhận")
                                                                      ],
                                                                    ),
                                                                    confirm: Obx(() => controller.isLoading.value
                                                                        ? const CircularProgressIndicator(
                                                                            color:
                                                                                Colors.orangeAccent,
                                                                          )
                                                                        : ButtonComment(
                                                                            text: "Xác nhận",
                                                                            onPressed: () {
                                                                              controller.postSetRuning(idList: "th", firstIndex: i, id: controller.newListDataForGive[i].getData![k].handlingId!, secondIndex: k);
                                                                            })),
                                                                    cancel: ButtonComment(
                                                                        text: "Hủy",
                                                                        onPressed: () {
                                                                          Get.back();
                                                                        }));
                                                              })
                                                          : ButtonFinal(
                                                              text:
                                                                  "Hoàn thành",
                                                              onPressed: () {})
                                                      : ButtonFinal(
                                                          text: "",
                                                          onPressed: () {})
                                                  : ButtonFinal(
                                                      text: "Hoàn thành",
                                                      onPressed: () {});
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
                                          ? ButtonComment(
                                              text: "Đã đến", onPressed: () {})
                                          : ButtonComment(
                                              text: "Đến",
                                              onPressed: () {
                                                controller.updateGiveEmpty(
                                                  index: i,
                                                  placeId: int.parse(
                                                    controller
                                                        .listOrder
                                                        .value
                                                        .getDataHandlingMobiles![
                                                            0]
                                                        .maDiemTraRong
                                                        .toString(),
                                                  ),
                                                );
                                              });
                                    }),
                                    ButtonComment(
                                        text: "Phụ phí",
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
                                        })
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
                                          () => controller.isLoadStatus.value
                                              ? controller.isPlacedGiveEmpty[i]
                                                  ? controller
                                                              .newListDataForGiveEmpty[
                                                                  i]
                                                              .getData![k]
                                                              .maTrangThai ==
                                                          35
                                                      ? const TextCustom(
                                                          text: "Đang trả rỗng")
                                                      : const TextCustom(
                                                          text: "Đã trả rỗng")
                                                  : const Text("")
                                              : Container(),
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
                                            label: const TextCustomComment(
                                                text: "Ghi chú")),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ButtonComment(
                                            text: "Chứng từ",
                                            onPressed: () {
                                              Get.toNamed(Routes.CAMERA,
                                                  arguments: [
                                                    controller
                                                        .newListDataForGiveEmpty[
                                                            i]
                                                        .getData![k],
                                                    controller
                                                        .newListDataForGiveEmpty[
                                                            i]
                                                        .getData![k]
                                                        .maDiemTraRong
                                                  ]);
                                            }),
                                        Obx(() => controller
                                                .isPlacedGiveEmpty[i]
                                            ? controller.isLoadStatus.value
                                                ? controller
                                                            .newListDataForGiveEmpty[
                                                                i]
                                                            .getData![k]
                                                            .maTrangThai ==
                                                        35
                                                    ? ButtonError(
                                                        text: "Hủy hoàn thành",
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
                                                                        "tr",
                                                                    firstIndex:
                                                                        i,
                                                                    id: controller
                                                                        .newListDataForGiveEmpty[
                                                                            i]
                                                                        .getData![
                                                                            k]
                                                                        .handlingId!,
                                                                    secondsIndex:
                                                                        k);
                                                              }
                                                            },
                                                          );
                                                        })
                                                    : ButtonFinal(
                                                        text: "Hủy hoàn thành",
                                                        onPressed: () {})
                                                : ButtonFinal(
                                                    text: "", onPressed: () {})
                                            : ButtonFinal(
                                                text: "Hủy hoàn thành",
                                                onPressed: () {})),
                                        Obx(() {
                                          return controller.isPlacedGiveEmpty[i]
                                              ? controller.isLoadStatus.value
                                                  ? controller
                                                              .newListDataForGiveEmpty[
                                                                  i]
                                                              .getData![k]
                                                              .maTrangThai ==
                                                          35
                                                      ? ButtonSuccess(
                                                          text: "Hoàn thành",
                                                          onPressed: () {
                                                            Get.defaultDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
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
                                                                confirm: Obx(() => controller
                                                                        .isLoading
                                                                        .value
                                                                    ? const CircularProgressIndicator(
                                                                        color: Colors
                                                                            .orangeAccent,
                                                                      )
                                                                    : ButtonComment(
                                                                        text:
                                                                            "Xác nhận",
                                                                        onPressed:
                                                                            () {
                                                                          print(
                                                                              Get.isSnackbarOpen);
                                                                          controller.postSetRuning(
                                                                              idList: "tr",
                                                                              firstIndex: i,
                                                                              id: controller.newListDataForGiveEmpty[i].getData![k].handlingId!,
                                                                              secondIndex: k);
                                                                        })),
                                                                cancel:
                                                                    ButtonComment(
                                                                        text:
                                                                            "Hủy",
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                        }));
                                                          })
                                                      : ButtonFinal(
                                                          text: "Hoàn thành",
                                                          onPressed: () {})
                                                  : const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            Colors.orangeAccent,
                                                      ),
                                                    )
                                              : ButtonFinal(
                                                  text: "Hoàn thành",
                                                  onPressed: () {});
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

  Widget _buttonStatus({
    required String text,
    required VoidCallback onPressed,
    required Color color,
  }) {
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
}
