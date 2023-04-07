import 'dart:math' as math;
import 'package:expandable/expandable.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tbs_logistics_tms/app/start_detail_tms/controller/details_pending_working_controller.dart';
import 'package:tbs_logistics_tms/config/core/data/color.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';

class DetailsPendingWorkingScreen
    extends GetView<DetailsPendingWorkingController> {
  const DetailsPendingWorkingScreen({super.key});
  final String routes = "/DETAILS_PENDING_WORKING_SCREEN";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết công việc"),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        backgroundColor: CustomColor.backgroundAppbar,
        leading: IconButton(
          onPressed: () async {
            Get.back(result: true);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: GetBuilder<DetailsPendingWorkingController>(
        init: DetailsPendingWorkingController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                controller.handingMobiles.value.loaiVanDon == "nhap"
                    ? ExpandableNotifier(
                        child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ScrollOnExpand(
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: <Widget>[
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
                                      child: Row(
                                        children: [
                                          ExpandableIcon(
                                            theme: const ExpandableThemeData(
                                              expandIcon: Icons.arrow_right,
                                              collapseIcon:
                                                  Icons.arrow_drop_down,
                                              iconColor: Color(0xffE18229),
                                              iconSize: 35.0,
                                              iconRotationAngle: math.pi / 2,
                                              iconPadding:
                                                  EdgeInsets.only(right: 5),
                                              hasIcon: false,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text("Đơn nhận",
                                                style: TextStyle(
                                                  color: Color(0xffE18229),
                                                  fontSize: 18,
                                                  // fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  collapsed: Container(),
                                  expanded: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    height: 90,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 45,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${controller.handingMobiles.value.maVanDon}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: CustomColor
                                                      .colorButonPendingOri,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Get.toNamed(
                                                      Routes
                                                          .NOTE_PENDING_SCREEN,
                                                      arguments: controller
                                                          .handingMobiles
                                                          .value
                                                          .handlingId,
                                                    );
                                                  },
                                                  child: Text(
                                                    "Ghi chú",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 45,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 35,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  color: CustomColor
                                                      .colorButonPendingOri,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    print(controller
                                                        .handingMobiles.value);
                                                    Get.toNamed(
                                                      Routes.CAMERA,
                                                      arguments: controller
                                                          .handingMobiles.value,
                                                    );
                                                  },
                                                  child: Text(
                                                    "Chụp chứng từ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  color: CustomColor
                                                      .colorButonPendingRed,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Get.toNamed(
                                                      Routes
                                                          .CANCEL_PENDING_SCREEN,
                                                      arguments: controller
                                                          .handingMobiles
                                                          .value
                                                          .handlingId,
                                                    );
                                                  },
                                                  child: Text(
                                                    "Hủy nhận hàng",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              controller.idPTVC.value == "FCL"
                                                  ? Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        border: Border.all(
                                                          color: Colors.green,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          controller
                                                              .postSetRuningTypeFull(
                                                            handlingId: controller
                                                                .handingMobiles
                                                                .value
                                                                .handlingId
                                                                .toString(),
                                                          );
                                                        },
                                                        child: Text(
                                                          "Hoàn thành",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        border: Border.all(
                                                          color: Colors.green,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          controller
                                                              .postSetRuning(
                                                            maChuyen: controller
                                                                .idChuyen.value,
                                                          );
                                                        },
                                                        child: Text(
                                                          "Hoàn thành",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                    : ExpandableNotifier(
                        child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ScrollOnExpand(
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: <Widget>[
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
                                      child: Row(
                                        children: [
                                          ExpandableIcon(
                                            theme: const ExpandableThemeData(
                                              expandIcon: Icons.arrow_right,
                                              collapseIcon:
                                                  Icons.arrow_drop_down,
                                              iconColor: Color(0xffE18229),
                                              iconSize: 35.0,
                                              iconRotationAngle: math.pi / 2,
                                              iconPadding:
                                                  EdgeInsets.only(right: 5),
                                              hasIcon: false,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text("Đơn giao",
                                                style: TextStyle(
                                                  color: Color(0xffE18229),
                                                  fontSize: 18,
                                                  // fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  collapsed: Container(),
                                  expanded: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    height: 90,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 45,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${controller.handingMobiles.value.maVanDon}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: CustomColor
                                                      .colorButonPendingOri,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    print(controller
                                                        .handingMobiles
                                                        .value
                                                        .handlingId);
                                                    Get.toNamed(
                                                      Routes
                                                          .NOTE_PENDING_SCREEN,
                                                      arguments: controller
                                                          .handingMobiles
                                                          .value
                                                          .handlingId,
                                                    );
                                                  },
                                                  child: Text(
                                                    "Ghi chú",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 45,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 35,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  color: CustomColor
                                                      .colorButonPendingOri,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    print([
                                                      controller
                                                          .handingMobiles.value,
                                                      controller.handingMobiles
                                                          .value.handlingId,
                                                    ]);
                                                    Get.toNamed(
                                                      Routes.CAMERA,
                                                      arguments: controller
                                                          .handingMobiles.value,
                                                    );
                                                  },
                                                  child: Text(
                                                    "Chụp chứng từ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  color: CustomColor
                                                      .colorButonPendingRed,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    print(
                                                      controller.handingMobiles
                                                          .value.handlingId,
                                                    );
                                                    Get.toNamed(
                                                      Routes
                                                          .CANCEL_PENDING_SCREEN,
                                                      arguments: controller
                                                          .handingMobiles
                                                          .value
                                                          .handlingId,
                                                    );
                                                  },
                                                  child: Text(
                                                    "Hủy giao hàng",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  border: Border.all(
                                                    color: Colors.green,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    controller
                                                        .postSetRuningTypeFull(
                                                      handlingId: controller
                                                          .handingMobiles
                                                          .value
                                                          .handlingId
                                                          .toString(),
                                                    );
                                                  },
                                                  child: Text(
                                                    "Hoàn thành",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                Container(
                  height: 50,
                  width: size.width,
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 90, 155, 213),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(
                              Routes.SUR_CHANGE_SCREEN,
                              arguments:
                                  controller.handingMobiles.value.handlingId,
                            );
                          },
                          child: const Text(
                            "Phụ phí",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 90, 155, 213),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextButton(
                          onPressed: () {
                            controller.postSetRuning(
                              maChuyen: controller.idChuyen.value,
                            );
                          },
                          child: const Text(
                            "Hoàn thành tất cả",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildItem(String label) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(label),
    );
  }

  buildList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (ctx, i) {
          return ListTile(
            title: Text("data"),
          );
        },
      ),
    );
  }
}
