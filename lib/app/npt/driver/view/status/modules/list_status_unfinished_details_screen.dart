// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:tbs_logistics_tms/app/npt/customer/model/list_driver_by_customer_model.dart';
import 'package:tbs_logistics_tms/app/npt/driver/model/status_driver_model.dart';
import 'package:tbs_logistics_tms/app/npt/driver/view/status/controller/list_status_unfinished_details_controller.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';
import 'package:tbs_logistics_tms/config/widget/custom_timeline.dart';

class ListStatusUnfinishedDetailsScreen
    extends GetView<ListStatusUnfinishedDetailsController> {
  const ListStatusUnfinishedDetailsScreen({super.key});
  final String routes = "/LIST_STATUS_UNFINISHED_DETAIL_SCREEN";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ListStatusUnfinishedDetailsController>(
      init: ListStatusUnfinishedDetailsController(),
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
                print(controller.getStatusDriver.value.maPhieuvao);
                Get.toNamed(
                  Routes.QR_CODE_SCREEN,
                  arguments: controller.getStatusDriver.value.maPhieuvao,
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
          child: Stack(
            children: [
              Obx(
                () {
                  return controller.isStatusDriver.value
                      ? controller.getStatusDriver.value.trackingtime != null
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildNameKH(controller, size, context,
                                        controller.getStatusDriver.value),
                                    SizedBox(
                                      height: size.width * 0.05,
                                    ),
                                    _buildNameCar(controller, size, context,
                                        controller.getStatusDriver.value),
                                    SizedBox(
                                      height: size.width * 0.05,
                                    ),
                                    _buildStatus(size, controller, context,
                                        controller.getStatusDriver.value),
                                    SizedBox(
                                      height: size.width * 0.05,
                                    ),
                                    controller.showForm.value
                                        ? _buildFormStatus(controller, size,
                                            controller.getStatusDriver.value)
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
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.getStatusDriver.value.trackingtime != null
                        ? InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                barrierDismissible: false,
                                title: "Chia sẻ phiếu",
                                content: Column(
                                  children: [
                                    // Theme(
                                    //   data: ThemeData(
                                    //     inputDecorationTheme:
                                    //         const InputDecorationTheme(
                                    //             border: InputBorder.none),
                                    //   ),
                                    //   child: DropdownSearch<
                                    //       ListDriverByCustomerModel>(
                                    //     asyncItems: (String? query) {
                                    //       return controller.getData(query);
                                    //     },
                                    //     popupProps: PopupProps.dialog(
                                    //       showSelectedItems: true,
                                    //       itemBuilder:
                                    //           _customPopupItemBuilderExample2,
                                    //       showSearchBox: true,
                                    //     ),
                                    //     compareFn: (item, sItem) {
                                    //       return item.maTaixe == sItem.maTaixe;
                                    //     },
                                    //     onChanged: (ListDriverByCustomerModel?
                                    //         newValue) {
                                    //       controller.selectedTaixe =
                                    //           newValue!.maTaixe.toString();
                                    //     },
                                    //     dropdownDecoratorProps:
                                    //         DropDownDecoratorProps(
                                    //       dropdownSearchDecoration:
                                    //           InputDecoration(
                                    //         hintText: "Chọn tài xế ",
                                    //         hintStyle: TextStyle(
                                    //           color: Theme.of(context)
                                    //               .primaryColorLight,
                                    //         ),
                                    //         filled: true,
                                    //         iconColor: const Color(0xFFF3BD60),
                                    //         focusColor: const Color(0xFFF3BD60),
                                    //         // fillColor: Colors.white,
                                    //         focusedBorder:
                                    //             const OutlineInputBorder(
                                    //           borderSide: BorderSide(
                                    //               color: Color(0xFFF3BD60),
                                    //               width: 1.0),
                                    //         ),
                                    //         enabledBorder:
                                    //             const OutlineInputBorder(
                                    //           borderSide: BorderSide(
                                    //               color: Color(0xFFF3BD60),
                                    //               width: 1.0),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          print([
                                            controller.selectedTaixe,
                                            controller.getStatusDriver.value
                                                .maPhieuvao
                                          ]);
                                          controller.shareDriver(
                                              maTaiXe: int.parse(
                                                  controller.selectedTaixe),
                                              maPhieuVao: int.parse(controller
                                                  .getStatusDriver
                                                  .value
                                                  .maPhieuvao
                                                  .toString()));
                                        },
                                        child: const Text(
                                          "Gửi",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/share.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  Widget _buildFormStatus(ListStatusUnfinishedDetailsController controller,
      Size size, StatusDriverModel items) {
    // ignore: unused_local_variable
    var length = items.trackingtime!.length;
    var day = DateFormat("yyy-MM-dd");
    var hour = DateFormat("hh:mm a");
    print(items.trackingtime!.length);
    return items.trackingtime != null
        ? SizedBox(
            height: 80 * 5 + 20,
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
                          items.trackingtime![0].thoigian.toString(),
                        ),
                      )}"),
                      Text("Giờ : ${hour.format(
                        DateTime.parse(
                          items.trackingtime![0].thoigian.toString(),
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
                  contentRight: items.trackingtime!.length >= 2
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Ngày : ${day.format(
                              DateTime.parse(
                                items.trackingtime![1].thoigian.toString(),
                              ),
                            )}"),
                            Text("Giờ : ${hour.format(
                              DateTime.parse(
                                items.trackingtime![1].thoigian.toString(),
                              ),
                            )}"),
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
                  contentRight: items.trackingtime!.length >= 3
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Ngày : ${day.format(
                              DateTime.parse(
                                items.trackingtime![2].thoigian.toString(),
                              ),
                            )}"),
                            Text("Giờ : ${hour.format(
                              DateTime.parse(
                                items.trackingtime![2].thoigian.toString(),
                              ),
                            )}"),
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
                  contentRight: items.trackingtime!.length >= 4
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Ngày : ${day.format(
                              DateTime.parse(
                                items.trackingtime![3].thoigian.toString(),
                              ),
                            )}"),
                            Text("Giờ : ${hour.format(
                              DateTime.parse(
                                items.trackingtime![3].thoigian.toString(),
                              ),
                            )}"),
                          ],
                        )
                      : Container(),
                  image: items.trackingtime!.length >= 4
                      ? const AssetImage("assets/timelines/start_worked.png")
                      : const AssetImage("assets/timelines/start_working.png"),
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
                  contentRight: items.trackingtime!.length >= 5
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Ngày : ${day.format(
                              DateTime.parse(
                                items.trackingtime![4].thoigian.toString(),
                              ),
                            )}"),
                            Text("Giờ : ${hour.format(
                              DateTime.parse(
                                items.trackingtime![4].thoigian.toString(),
                              ),
                            )}"),
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
            ))
        : Container();
  }

  Widget _buildStatus(
      Size size,
      ListStatusUnfinishedDetailsController controller,
      BuildContext context,
      StatusDriverModel items) {
    return items.trackingtime != null
        ? InkWell(
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
                        Text(
                          "Trạng thái :",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${items.trackingtime![items.trackingtime!.length - 1].statustracking!.name}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.album_outlined,
                          color:
                              items.status == true ? Colors.green : Colors.red,
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
          )
        : Container();
  }

  Widget _buildNameKH(ListStatusUnfinishedDetailsController controller,
      Size size, BuildContext context, StatusDriverModel items) {
    return items.taixeRe != null
        ? Container(
            height: 80,
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
                            "Tên khách hàng",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
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
                                  ),
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
          )
        : Container();
  }

  Widget _buildNameCar(ListStatusUnfinishedDetailsController controller,
      Size size, BuildContext context, StatusDriverModel items) {
    return items.loaixeRe != null
        ? Container(
            height: 80,
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
          )
        : Container();
  }
}
