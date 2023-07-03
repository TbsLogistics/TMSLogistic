// import 'package:dropdown_search/dropdown_search.dart';
// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/widget/custom_timeline.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/model/driver_list_ticker_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status_details/model/list_driver_by_customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status_details/controller/driver_status_details_controller.dart';

class ListStatusUnfinishedDetailsScreen
    extends GetView<DriverStatusDetailsController> {
  const ListStatusUnfinishedDetailsScreen({super.key});
  final String routes = "/LIST_STATUS_UNFINISHED_DETAIL_SCREEN";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<DriverStatusDetailsController>(
      init: DriverStatusDetailsController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Chi tiết trạng thái",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).primaryColorLight,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(
                  Routes.CREATE_EDIT_REGISTER_DRIVER,
                  arguments: controller.getDriverFinishedScreen.value,
                );
              },
              icon: Icon(
                Icons.edit_document,
                color: Theme.of(context).primaryColorLight,
                size: 25,
              ),
            ),
            controller.getDriverFinishedScreen.value.giovao == null
                ? IconButton(
                    onPressed: () {
                      getDialogMessage(
                        messageText: "Bạn có chắc chắn xóa phiếu !",
                        onPressed: () {},
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).primaryColorLight,
                      size: 25,
                    ),
                  )
                : Container(),
            const SizedBox(width: 15),
          ],
        ),
        body: SizedBox(
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () {
                      return controller.isDriverFinishedScreen.value
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildNameKH(
                                        controller,
                                        size,
                                        context,
                                        controller
                                            .getDriverFinishedScreen.value),
                                    SizedBox(
                                      height: size.width * 0.05,
                                    ),
                                    _buildNameCar(
                                        controller,
                                        size,
                                        context,
                                        controller
                                            .getDriverFinishedScreen.value),
                                    SizedBox(
                                      height: size.width * 0.05,
                                    ),
                                    // _buildStatus(
                                    //     size,
                                    //     controller,
                                    //     context,
                                    //     controller
                                    //         .getDriverFinishedScreen.value),
                                    _qrImage(controller, size),
                                    // controller.showForm.value
                                    //     ? _buildFormStatus(
                                    //         controller,
                                    //         size,
                                    //         controller
                                    //             .getDriverFinishedScreen.value)
                                    //     : Container(),
                                    SizedBox(
                                      height: size.width * 0.05,
                                    ),
                                    _buildNumberCont(controller, size, context),
                                  ],
                                ),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: Colors.orangeAccent,
                              ),
                            );
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _qrImage(DriverStatusDetailsController controller, Size size) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 10,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.orangeAccent,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: RepaintBoundary(
                key: controller.qrDriverKey,
                child: Obx(() {
                  return QrImage(
                    backgroundColor: Colors.white,
                    data:
                        "${controller.getDriverFinishedScreen.value.pdriverInOutWarehouseCode}",
                    version: QrVersions.auto,
                    size: size.width * 0.3,
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextButton.icon(
              onPressed: controller.onShare,
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              label: const Text(
                "Share",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(
    BuildContext context,
    ListDriverByCustomerModel? item,
    bool isSelected,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        // color: Colors.green,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color(0xFFF3BD60),
          ),

          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
        child: ListTile(
          style: ListTileStyle.drawer,
          focusColor: Colors.white,
          title: Text(
            item?.tenTaixe ?? '',
            style: const TextStyle(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  // Widget _buildFormStatus(DriverStatusDetailsController controller, Size size,
  //     DriverListTickerModel items) {
  //   // ignore: unused_local_variable

  //   var day = DateFormat("yyy-MM-dd");
  //   var hour = DateFormat("hh:mm a");

  //   return items.trackingtime != null
  //       ? Card(
  //           shadowColor: Colors.grey,
  //           elevation: 10,
  //           shape: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15),
  //             borderSide: const BorderSide(
  //               color: Colors.orangeAccent,
  //               width: 1,
  //             ),
  //           ),
  //           child: SizedBox(
  //               height: 80 * 5 + 20,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   CustomTimeLines(
  //                     contentLeft: const Padding(
  //                       padding: EdgeInsets.only(left: 15),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Text(
  //                                 "Đã đăng tài",
  //                                 style: TextStyle(
  //                                   color: Colors.green,
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     contentRight: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         Text(
  //                           "Ngày : ${day.format(
  //                             DateTime.parse(
  //                               items.trackingtime![0].thoigian.toString(),
  //                             ),
  //                           )}",
  //                           style: const TextStyle(
  //                             color: Colors.orangeAccent,
  //                             fontSize: 14,
  //                           ),
  //                         ),
  //                         Text(
  //                           "Giờ : ${hour.format(
  //                             DateTime.parse(
  //                               items.trackingtime![0].thoigian.toString(),
  //                             ),
  //                           )}",
  //                           style: const TextStyle(
  //                             color: Colors.orangeAccent,
  //                             fontSize: 14,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     image: const AssetImage("assets/timelines/result.png"),
  //                     height: 80,
  //                     colorLine: Colors.orangeAccent,
  //                   ),
  //                   CustomTimeLines(
  //                     contentLeft: const Padding(
  //                       padding: EdgeInsets.only(left: 15),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Text(
  //                                 "Đã vào cổng",
  //                                 style: TextStyle(
  //                                   color: Colors.green,
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     contentRight: items.trackingtime!.length >= 2
  //                         ? Column(
  //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                             children: [
  //                               Text(
  //                                 "Ngày : ${day.format(
  //                                   DateTime.parse(
  //                                     items.trackingtime![1].thoigian
  //                                         .toString(),
  //                                   ),
  //                                 )}",
  //                                 style: const TextStyle(
  //                                   color: Colors.orangeAccent,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "Giờ : ${hour.format(
  //                                   DateTime.parse(
  //                                     items.trackingtime![1].thoigian
  //                                         .toString(),
  //                                   ),
  //                                 )}",
  //                                 style: const TextStyle(
  //                                   color: Colors.orangeAccent,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         : Container(),
  //                     image: items.trackingtime!.length == 2
  //                         ? const AssetImage("assets/timelines/in_car.png")
  //                         : const AssetImage("assets/timelines/in_cared.png"),
  //                     height: 80,
  //                     colorLine: Colors.orangeAccent,
  //                   ),
  //                   CustomTimeLines(
  //                     contentLeft: const Padding(
  //                       padding: EdgeInsets.only(left: 15),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Text(
  //                                 "Đã vào dock",
  //                                 style: TextStyle(
  //                                   color: Colors.green,
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     contentRight: items.trackingtime!.length >= 3
  //                         ? Column(
  //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                             children: [
  //                               Text(
  //                                 "Ngày : ${day.format(
  //                                   DateTime.parse(
  //                                     items.trackingtime![2].thoigian
  //                                         .toString(),
  //                                   ),
  //                                 )}",
  //                                 style: const TextStyle(
  //                                   color: Colors.orangeAccent,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "Giờ : ${hour.format(
  //                                   DateTime.parse(
  //                                     items.trackingtime![2].thoigian
  //                                         .toString(),
  //                                   ),
  //                                 )}",
  //                                 style: const TextStyle(
  //                                   color: Colors.orangeAccent,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         : Container(),
  //                     image: items.trackingtime!.length >= 3
  //                         ? const AssetImage("assets/timelines/paked.png")
  //                         : const AssetImage("assets/timelines/paking.png"),
  //                     height: 80,
  //                     colorLine: Colors.orangeAccent,
  //                   ),
  //                   CustomTimeLines(
  //                     contentLeft: const Padding(
  //                       padding: EdgeInsets.only(left: 15),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Text(
  //                                 "Bắt đầu làm hàng",
  //                                 style: TextStyle(
  //                                   color: Colors.green,
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     contentRight: items.trackingtime!.length >= 4
  //                         ? Column(
  //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                             children: [
  //                               Text(
  //                                 "Ngày : ${day.format(
  //                                   DateTime.parse(
  //                                     items.trackingtime![3].thoigian
  //                                         .toString(),
  //                                   ),
  //                                 )}",
  //                                 style: const TextStyle(
  //                                   color: Colors.orangeAccent,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "Giờ : ${hour.format(
  //                                   DateTime.parse(
  //                                     items.trackingtime![3].thoigian
  //                                         .toString(),
  //                                   ),
  //                                 )}",
  //                                 style: const TextStyle(
  //                                   color: Colors.orangeAccent,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         : Container(),
  //                     image: items.trackingtime!.length >= 4
  //                         ? const AssetImage(
  //                             "assets/timelines/start_worked.png")
  //                         : const AssetImage(
  //                             "assets/timelines/start_working.png"),
  //                     height: 80,
  //                     colorLine: Colors.orangeAccent,
  //                   ),
  //                   CustomTimeLines(
  //                     contentLeft: const Padding(
  //                       padding: EdgeInsets.only(left: 15),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Text(
  //                                 "Làm hàng xong",
  //                                 style: TextStyle(
  //                                   color: Colors.green,
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     contentRight: items.trackingtime!.length >= 5
  //                         ? Column(
  //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                             children: [
  //                               Text(
  //                                 "Ngày : ${day.format(
  //                                   DateTime.parse(
  //                                     items.trackingtime![4].thoigian
  //                                         .toString(),
  //                                   ),
  //                                 )}",
  //                                 style: const TextStyle(
  //                                   color: Colors.orangeAccent,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "Giờ : ${hour.format(
  //                                   DateTime.parse(
  //                                     items.trackingtime![4].thoigian
  //                                         .toString(),
  //                                   ),
  //                                 )}",
  //                                 style: const TextStyle(
  //                                   color: Colors.orangeAccent,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         : Container(),
  //                     image: items.trackingtime!.length >= 5
  //                         ? const AssetImage("assets/timelines/finished.png")
  //                         : const AssetImage("assets/timelines/finish.png"),
  //                     height: 80,
  //                     colorLine: Colors.orangeAccent,
  //                   ),
  //                   Container(
  //                     height: 20,
  //                   )
  //                 ],
  //               )),
  //         )
  //       : Container();
  // }

  // Widget _buildStatus(Size size, DriverStatusDetailsController controller,
  //     BuildContext context, DriverListTickerModel items) {
  //   return items.trackingtime != null
  //       ? Card(
  //           shadowColor: Colors.grey,
  //           elevation: 10,
  //           shape: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15),
  //             borderSide: const BorderSide(
  //               color: Colors.orangeAccent,
  //               width: 1,
  //             ),
  //           ),
  //           child: InkWell(
  //             onTap: () {
  //               // controller.showFormStatus();
  //             },
  //             child: Container(
  //               height: 40,
  //               decoration: BoxDecoration(
  //                 border: Border.all(
  //                   width: 1,
  //                   color: Colors.orangeAccent,
  //                 ),
  //                 borderRadius: BorderRadius.circular(15),
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   Expanded(
  //                     flex: 4,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         const Text(
  //                           "Trạng thái :",
  //                           style: TextStyle(
  //                             color: Colors.green,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                         const SizedBox(width: 10),
  //                         Text(
  //                           "${items.trackingtime![items.trackingtime!.length - 1].statustracking!.name}",
  //                           style: const TextStyle(
  //                               fontSize: 16, color: Colors.orangeAccent),
  //                         ),
  //                         const SizedBox(width: 10),
  //                         Icon(
  //                           Icons.album_outlined,
  //                           color: items.status == true
  //                               ? Colors.green
  //                               : Colors.red,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   const Expanded(
  //                     flex: 1,
  //                     child: Center(
  //                       child: Icon(
  //                         Icons.arrow_drop_down_sharp,
  //                         size: 32,
  //                         color: Colors.orangeAccent,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         )
  //       : Container();
  // }

  Widget _buildNameKH(DriverStatusDetailsController controller, Size size,
      BuildContext context, DriverListTickerModel items) {
    return items.maKhachHang != null
        ? Card(
            shadowColor: Colors.grey,
            elevation: 10,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.orangeAccent,
                width: 1,
              ),
            ),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: Colors.orangeAccent,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "Tên khách hàng",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: items.maKhachHang != null
                                ? Text(
                                    "${items.maKhachHang!.tenKhachhang}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.orangeAccent),
                                  )
                                : const Text(""),
                          ),
                        )
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    width: 1,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.orangeAccent,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _buildNameCar(DriverStatusDetailsController controller, Size size,
      BuildContext context, DriverListTickerModel items) {
    return items.loaixe != null
        ? Card(
            shadowColor: Colors.grey,
            elevation: 10,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.orangeAccent,
                width: 1,
              ),
            ),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: Colors.orangeAccent,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "Loại xe",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Text(
                              "${items.loaixe!.tenLoaiXe}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.orangeAccent),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    width: 1,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.orangeAccent,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "Số xe",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Text(
                              "${items.soxe}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.orangeAccent),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}

Widget _buildNumberCont(
    DriverStatusDetailsController items, Size size, BuildContext context) {
  var itemsCont = items.getDriverFinishedScreen.value;
  return Container(
    height: size.width * 0.9,
    padding: const EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.orangeAccent,
      ),
      borderRadius: BorderRadius.circular(15),
      // color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Số công 1",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                    // const SizedBox(height: 10),
                    Text(
                      itemsCont.socont1 != null ? "${itemsCont.socont1}" : "",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorLight),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số seal 1",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            itemsCont.cont1seal1 != null
                                ? "${itemsCont.cont1seal1}"
                                : "",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số seal 2",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            itemsCont.cont1seal2 != null
                                ? "${itemsCont.cont1seal2}"
                                : "",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số Book",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            itemsCont.soBook != null
                                ? "${itemsCont.soBook}"
                                : "",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số Kiện",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${itemsCont.soKien}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số Khối (CBM)",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${itemsCont.sokhoi}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số Khối (CBM)",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${itemsCont.soTan}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(
          width: 1,
          indent: 15,
          endIndent: 15,
          color: Colors.orangeAccent,
          thickness: 1,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Số công 2",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      itemsCont.socont2 != null ? "${itemsCont.socont2}" : "",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorLight),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số seal 1",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            itemsCont.cont2seal1 != null
                                ? "${itemsCont.cont2seal1}"
                                : "",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số seal 2",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            itemsCont.cont2seal2 != null
                                ? "${itemsCont.cont2seal2}"
                                : "",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số Book",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            itemsCont.soBook1 != null
                                ? "${itemsCont.soBook1}"
                                : "",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số Kiện",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${itemsCont.sokien1}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số Khối (CBM)",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${itemsCont.sokhoi1}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Số Khối (CBM)",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${itemsCont.soTan1}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void getDialogMessage(
    {required String messageText, required VoidCallback onPressed}) {
  Get.defaultDialog(
    backgroundColor: Colors.white,
    title: "Thông báo",
    titleStyle: const TextStyle(
        color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
    content: SizedBox(
      height: 60,
      width: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  messageText,
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    cancel: Container(
      height: 40,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          "Trở về",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    ),
    confirm: Container(
      height: 40,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          "Xác nhận",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    ),
  );
}
