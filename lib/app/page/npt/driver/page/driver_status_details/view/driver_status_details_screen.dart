// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/widget/custom_timeline.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status_details/model/list_driver_by_customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/model/status_driver_model.dart';
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
                  Routes.QR_CODE_DRIVER_SCREEN,
                  arguments:
                      controller.getDriverFinishedScreen.value.maPhieuvao,
                );
              },
              icon: Icon(
                Icons.qr_code_rounded,
                color: Theme.of(context).primaryColorLight,
                size: 25,
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: Container(
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () {
                      return controller.isDriverFinishedScreen.value
                          ? controller.getDriverFinishedScreen.value
                                      .trackingtime !=
                                  null
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                        _buildStatus(
                                            size,
                                            controller,
                                            context,
                                            controller
                                                .getDriverFinishedScreen.value),
                                        SizedBox(
                                          height: size.width * 0.05,
                                        ),
                                        controller.showForm.value
                                            ? _buildFormStatus(
                                                controller,
                                                size,
                                                controller
                                                    .getDriverFinishedScreen
                                                    .value)
                                            : Container(),
                                        SizedBox(
                                          height: size.width * 0.05,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                    "Tài xế chưa hoạt động ! ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 22,
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

  Widget _buildFormStatus(DriverStatusDetailsController controller, Size size,
      DriverFinishedScreenModel items) {
    // ignore: unused_local_variable
    var length = items.trackingtime!.length;
    var day = DateFormat("yyy-MM-dd");
    var hour = DateFormat("hh:mm a");

    return items.trackingtime != null
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
                height: 80 * 5 + 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTimeLines(
                      contentLeft: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Đã đăng tài",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      contentRight: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Ngày : ${day.format(
                              DateTime.parse(
                                items.trackingtime![0].thoigian.toString(),
                              ),
                            )}",
                            style: const TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Giờ : ${hour.format(
                              DateTime.parse(
                                items.trackingtime![0].thoigian.toString(),
                              ),
                            )}",
                            style: const TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      image: const AssetImage("assets/timelines/result.png"),
                      height: 80,
                      colorLine: Colors.orangeAccent,
                    ),
                    CustomTimeLines(
                      contentLeft: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Đã vào cổng",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      contentRight: items.trackingtime!.length >= 2
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Ngày : ${day.format(
                                    DateTime.parse(
                                      items.trackingtime![1].thoigian
                                          .toString(),
                                    ),
                                  )}",
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Giờ : ${hour.format(
                                    DateTime.parse(
                                      items.trackingtime![1].thoigian
                                          .toString(),
                                    ),
                                  )}",
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      image: items.trackingtime!.length == 2
                          ? const AssetImage("assets/timelines/in_car.png")
                          : const AssetImage("assets/timelines/in_cared.png"),
                      height: 80,
                      colorLine: Colors.orangeAccent,
                    ),
                    CustomTimeLines(
                      contentLeft: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Đã vào dock",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      contentRight: items.trackingtime!.length >= 3
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Ngày : ${day.format(
                                    DateTime.parse(
                                      items.trackingtime![2].thoigian
                                          .toString(),
                                    ),
                                  )}",
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Giờ : ${hour.format(
                                    DateTime.parse(
                                      items.trackingtime![2].thoigian
                                          .toString(),
                                    ),
                                  )}",
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      image: items.trackingtime!.length >= 3
                          ? const AssetImage("assets/timelines/paked.png")
                          : const AssetImage("assets/timelines/paking.png"),
                      height: 80,
                      colorLine: Colors.orangeAccent,
                    ),
                    CustomTimeLines(
                      contentLeft: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Bắt đầu làm hàng",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      contentRight: items.trackingtime!.length >= 4
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Ngày : ${day.format(
                                    DateTime.parse(
                                      items.trackingtime![3].thoigian
                                          .toString(),
                                    ),
                                  )}",
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Giờ : ${hour.format(
                                    DateTime.parse(
                                      items.trackingtime![3].thoigian
                                          .toString(),
                                    ),
                                  )}",
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      image: items.trackingtime!.length >= 4
                          ? const AssetImage(
                              "assets/timelines/start_worked.png")
                          : const AssetImage(
                              "assets/timelines/start_working.png"),
                      height: 80,
                      colorLine: Colors.orangeAccent,
                    ),
                    CustomTimeLines(
                      contentLeft: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Làm hàng xong",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      contentRight: items.trackingtime!.length >= 5
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Ngày : ${day.format(
                                    DateTime.parse(
                                      items.trackingtime![4].thoigian
                                          .toString(),
                                    ),
                                  )}",
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Giờ : ${hour.format(
                                    DateTime.parse(
                                      items.trackingtime![4].thoigian
                                          .toString(),
                                    ),
                                  )}",
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      image: items.trackingtime!.length >= 5
                          ? const AssetImage("assets/timelines/finished.png")
                          : const AssetImage("assets/timelines/finish.png"),
                      height: 80,
                      colorLine: Colors.orangeAccent,
                    ),
                    Container(
                      height: 20,
                    )
                  ],
                )),
          )
        : Container();
  }

  Widget _buildStatus(Size size, DriverStatusDetailsController controller,
      BuildContext context, DriverFinishedScreenModel items) {
    return items.trackingtime != null
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
            child: InkWell(
              onTap: () {
                controller.showFormStatus();
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.orangeAccent,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Trạng thái :",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${items.trackingtime![items.trackingtime!.length - 1].statustracking!.name}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.orangeAccent),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.album_outlined,
                            color: items.status == true
                                ? Colors.green
                                : Colors.red,
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
          )
        : Container();
  }

  Widget _buildNameKH(DriverStatusDetailsController controller, Size size,
      BuildContext context, DriverFinishedScreenModel items) {
    return items.taixeRe != null
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
                            child: items.taixeRe!.khachhangRe != null
                                ? Text(
                                    "${items.taixeRe!.khachhangRe!.tenKhachhang}",
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
      BuildContext context, DriverFinishedScreenModel items) {
    return items.loaixeRe != null
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
                              "${items.loaixeRe!.tenLoaiXe}",
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
                              "${items.phieuvao!.soxe}",
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
