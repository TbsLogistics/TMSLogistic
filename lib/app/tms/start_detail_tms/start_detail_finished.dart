// ignore_for_file: unused_local_variable, avoid_unnecessary_containers

import "dart:math" as math;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/tms/start_detail_tms/controller/start_detail_finished_controller.dart';

import 'package:tbs_logistics_tms/app/tms/start_detail_tms/widgets/button_success.dart';
import 'package:tbs_logistics_tms/app/tms/start_detail_tms/widgets/text_success.dart';
import 'package:tbs_logistics_tms/config/core/data/color.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';

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
        builder: (controller) {
          var length =
              controller.listOrder.value.getDataHandlingMobiles!.length;
          return SingleChildScrollView(
            child: Container(
                // height: size.height,
                width: size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: controller.isLoad.value
                    ? Column(children: [
                        _buildReciveEmpty(size),
                        _buildRecive(size),
                        _buildGive(size),
                        _buildGiveEmpty(size),
                      ])
                    : Container()),
          );
        },
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
                                          ButtonFinal(
                                            text: "Hủy lấy rỗng",
                                            onPressed: () {},
                                          ),
                                          ButtonFinal(
                                            text: "Hoàn thành",
                                            onPressed: () {},
                                          )
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
                                            ButtonFinal(
                                              text: "Hủy lấy hàng",
                                              onPressed: () {},
                                            ),
                                            ButtonFinal(
                                              text: "Hoàn thành",
                                              onPressed: () {},
                                            ),
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
                                            ButtonFinal(
                                                text: "Hủy giao hàng",
                                                onPressed: () {}),
                                            ButtonFinal(
                                                text: "Hoàn thành",
                                                onPressed: () {}),
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
                                        ButtonFinal(
                                            text: "Hủy trả rỗng",
                                            onPressed: () {}),
                                        ButtonFinal(
                                            text: "Hoàn thành",
                                            onPressed: () {})
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
}
