import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/widget/custom_timeline.dart';

import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_driver_of_customer_details/controller/customer_list_driver_of_customer_details_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_driver_of_customer/model/list_tracking_model.dart';

class CustomerListDriverDetailsOfCustomerScreen
    extends GetView<CustomerListDriverDetailsOfCustomerController> {
  final String routes = "/CUSTOMER_DETAILS_INFO_DRIVER";

  const CustomerListDriverDetailsOfCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CustomerListDriverDetailsOfCustomerController>(
      init: CustomerListDriverDetailsOfCustomerController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Chi tiết thông tin tài xế",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 25,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       Get.toNamed(
          //         Routes.QR_CODE_CUSTOMER_SCREEN,
          //         arguments: [
          //           controller.statusDriver.value.maPhieuvao,
          //           controller.statusDriver.value.taixeRe!.maTaixe,
          //         ],
          //       );
          //     },
          //     icon: Icon(
          //       Icons.qr_code_rounded,
          //       color: Theme.of(context).primaryColorLight,
          //       size: 25,
          //     ),
          //   ),
          //   const SizedBox(width: 15),
          // ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildNameKH(controller.statusDriver.value, size, context),
                SizedBox(
                  height: size.width * 0.05,
                ),
                _buildNameCar(controller.statusDriver.value, size, context),
                SizedBox(
                  height: size.width * 0.05,
                ),
                _buildStatus(
                    size, controller.statusDriver.value, controller, context),
                _qrImage(controller, size),
                controller.showForm.value
                    ? _buildFormStatus(controller.statusDriver.value, size)
                    : Container(),
                SizedBox(
                  height: size.width * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _qrImage(
      CustomerListDriverDetailsOfCustomerController controller, Size size) {
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: RepaintBoundary(
                key: controller.qrKey,
                child: Obx(
                  () => QrImage(
                    backgroundColor: Colors.white,
                    data:
                        "${controller.statusDriver.value.maPhieuvao},${controller.statusDriver.value.taixeRe!.maTaixe}",
                    version: QrVersions.auto,
                    size: size.width * 0.3,
                    embeddedImage: const AssetImage('assets/images/asd.jpg'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: const Size.square(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
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

  Widget _buildFormStatus(ListTrackingModel item, Size size) {
    var length = item.trackingtime!.length;

    var day = DateFormat("dd-MM-yyyy");
    // ignore: unused_local_variable
    var hour = DateFormat("hh:mm a");
    return item.trackingtime != null
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
            child: SizedBox(
              height: 85 * 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTimeLines(
                    contentLeft: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Đã đăng tài",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    contentRight: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Ngày : ${day.format(
                          DateTime.parse(
                            item.trackingtime![0].thoigian.toString(),
                          ),
                        )}"),
                        Text("Giờ : ${hour.format(
                          DateTime.parse(
                            item.trackingtime![0].thoigian.toString(),
                          ),
                        )}"),
                      ],
                    ),
                    image: const AssetImage("assets/timelines/result.png"),
                    height: 80,
                    colorLine: Colors.orangeAccent,
                  ),
                  CustomTimeLines(
                    contentLeft: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Đã vào cổng",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    contentRight: item.trackingtime!.length == 2
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Ngày : ${day.format(
                                DateTime.parse(
                                  item.trackingtime![1].thoigian.toString(),
                                ),
                              )}"),
                              Text("Giờ : ${hour.format(
                                DateTime.parse(
                                  item.trackingtime![1].thoigian.toString(),
                                ),
                              )}"),
                            ],
                          )
                        : Container(),
                    image: item.trackingtime!.length == 2
                        ? const AssetImage("assets/timelines/in_car.png")
                        : const AssetImage("assets/timelines/in_cared.png"),
                    height: 80,
                    colorLine: Colors.orangeAccent,
                  ),
                  CustomTimeLines(
                    contentLeft: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Đã vào dock",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    contentRight: item.trackingtime!.length == 3
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Ngày : ${day.format(
                                DateTime.parse(
                                  item.trackingtime![0].thoigian.toString(),
                                ),
                              )}"),
                              Text("Giờ : ${hour.format(
                                DateTime.parse(
                                  item.trackingtime![0].thoigian.toString(),
                                ),
                              )}"),
                            ],
                          )
                        : Container(),
                    image: item.trackingtime!.length == 3
                        ? const AssetImage("assets/timelines/start_working.png")
                        : const AssetImage("assets/timelines/start_worked.png"),
                    height: 80,
                    colorLine: Colors.orangeAccent,
                  ),
                  CustomTimeLines(
                    contentLeft: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Bắt đầu làm hàng",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    contentRight: item.trackingtime!.length == 4
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Ngày : ${day.format(
                                DateTime.parse(
                                  item.trackingtime![3].thoigian.toString(),
                                ),
                              )}"),
                              Text("Giờ : ${hour.format(
                                DateTime.parse(
                                  item.trackingtime![3].thoigian.toString(),
                                ),
                              )}"),
                            ],
                          )
                        : Container(),
                    image: item.trackingtime!.length == 4
                        ? const AssetImage("assets/timelines/finish.png")
                        : const AssetImage("assets/timelines/finished.png"),
                    height: 80,
                    colorLine: Colors.orangeAccent,
                  ),
                  CustomTimeLines(
                    contentLeft: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Làm hàng xong",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    contentRight: item.trackingtime!.length >= 5
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Ngày : ${day.format(
                                DateTime.parse(
                                  item.trackingtime![4].thoigian.toString(),
                                ),
                              )}"),
                              Text("Giờ : ${hour.format(
                                DateTime.parse(
                                  item.trackingtime![4].thoigian.toString(),
                                ),
                              )}"),
                            ],
                          )
                        : Container(),
                    image: item.trackingtime!.length >= 5
                        ? const AssetImage("assets/timelines/finished.png")
                        : const AssetImage("assets/timelines/finish.png"),
                    height: 80,
                    colorLine: Colors.orangeAccent,
                  ),
                  Container(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _buildStatus(
      Size size,
      ListTrackingModel item,
      CustomerListDriverDetailsOfCustomerController controller,
      BuildContext context) {
    var length = item.trackingtime!.length;
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
      child: InkWell(
        onTap: () {
          controller.showFormStatus();
        },
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Trạng thái :",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${item.trackingtime![length - 1].statustracking!.name}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.album_outlined,
                      color: item.status == true ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: Center(
                  child: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 32,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameCar(
      ListTrackingModel item, Size size, BuildContext context) {
    return Container(
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
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Loại xe",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "${item.loaixeRe!.tenLoaiXe}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
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
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Số xe",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "${item.phieuvao!.soxe}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameKH(ListTrackingModel item, Size size, BuildContext context) {
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
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Tên khách hàng",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        item.taixeRe!.khachhangRe != null
                            ? "${item.taixeRe!.khachhangRe!.tenKhachhang}"
                            : "",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
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
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Số điện thoại",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        item.taixeRe!.khachhangRe != null
                            ? "${item.taixeRe!.khachhangRe!.tenKhachhang}"
                            : "",
                        style: const TextStyle(
                          fontSize: 16,
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
    );
  }
}
