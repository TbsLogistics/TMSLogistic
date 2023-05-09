import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/npt/customer/controller/customer_controller.dart';
import 'package:tbs_logistics_tms/config/widget/custom_timeline.dart';

class CustomerDetailsInfoDriver extends GetView<CustomerController> {
  final String routes = "/CUSTOMER_DETAILS_INFO_DRIVER";

  const CustomerDetailsInfoDriver({super.key});

  @override
  Widget build(BuildContext context) {
    var items = Get.arguments;
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CustomerController>(
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
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildNameKH(items, size, context),
                SizedBox(
                  height: size.width * 0.05,
                ),
                _buildNameCar(items, size, context),
                SizedBox(
                  height: size.width * 0.05,
                ),
                _buildStatus(size, items, controller, context),
                SizedBox(
                  height: size.width * 0.05,
                ),
                controller.showForm.value
                    ? _buildFormStatus(items, size)
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

  Widget _buildFormStatus(dynamic item, Size size) {
    var length = item["trackingtime"].length;

    var day = DateFormat("dd-MM-yyyy");
    // ignore: unused_local_variable
    var hour = DateFormat("hh:mm a");
    return item["trackingtime"] != null
        ? SizedBox(
            height: 80 * 4,
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
                          item["trackingtime"]![0].thoigian.toString(),
                        ),
                      )}"),
                      Text("Giờ : ${hour.format(
                        DateTime.parse(
                          item["trackingtime"]![0].thoigian.toString(),
                        ),
                      )}"),
                    ],
                  ),
                  image: const AssetImage("assets/timelines/result.png"),
                  height: 80,
                  colorLine: Colors.orangeAccent,
                ),
                CustomTimeLines(
                  contentLeft: item["trackingtime"]![1].thoigian != null
                      ? Column(
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
                        )
                      : Container(),
                  contentRight: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Ngày : ${day.format(
                        DateTime.parse(
                          item["trackingtime"]![1].thoigian.toString(),
                        ),
                      )}"),
                      Text("Giờ : ${hour.format(
                        DateTime.parse(
                          item["trackingtime"][1].thoigian.toString(),
                        ),
                      )}"),
                    ],
                  ),
                  image: item["trackingtime"]![1].thoigian == null
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
                        "Bắt đầu làm hàng",
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  contentRight: item["trackingtime"]!.length == 3
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Ngày : ${day.format(
                              DateTime.parse(
                                item["trackingtime"]![0].thoigian.toString(),
                              ),
                            )}"),
                            Text("Giờ : ${hour.format(
                              DateTime.parse(
                                item["trackingtime"]![0].thoigian.toString(),
                              ),
                            )}"),
                          ],
                        )
                      : Container(),
                  image: item["trackingtime"]!.length == 3
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
                        "Làm hàng xong",
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  contentRight: item["trackingtime"]!.length == 4
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Ngày : ${day.format(
                              DateTime.parse(
                                item["trackingtime"]![0].thoigian.toString(),
                              ),
                            )}"),
                            Text("Giờ : ${hour.format(
                              DateTime.parse(
                                item["trackingtime"]![0].thoigian.toString(),
                              ),
                            )}"),
                          ],
                        )
                      : Container(),
                  image: item["trackingtime"]!.length == 4
                      ? const AssetImage("assets/timelines/finish.png")
                      : const AssetImage("assets/timelines/finished.png"),
                  height: 80,
                  colorLine: Colors.orangeAccent,
                ),
              ],
            ))
        : Container();
  }

  Widget _buildStatus(Size size, dynamic item, CustomerController controller,
      BuildContext context) {
    var length = item["trackingtime"].length;
    return InkWell(
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
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${item["trackingtime"][length - 1]["Statustracking"]["name"]}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.album_outlined,
                    color: item["status"] == true ? Colors.green : Colors.red,
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
    );
  }

  Widget _buildNameCar(dynamic item, Size size, BuildContext context) {
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
                      "${item["loaixe_re"]["tenLoaiXe"]}",
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
                      "${item["phieuvao"]["soxe"]}",
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

  Widget _buildNameKH(dynamic item, Size size, BuildContext context) {
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
                      "${item["taixe_re"]["khachhang_re"]["tenKhachhang"]}",
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
                      "${item["taixe_re"]["khachhang_re"]["tenKhachhang"]}",
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
}
