import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/npt/driver/controller/register_details_driver_controller.dart';
import 'package:tbs_logistics_tms/app/npt/driver/model/register_driver_model.dart';
import 'package:tbs_logistics_tms/config/core/data/text_style.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';

class DetailsFormRegisterDriver
    extends GetView<RegisterDetailsDriverController> {
  const DetailsFormRegisterDriver({super.key});

  final String routes = "/DETAILS_FORM_REGISTER_DRIVER";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var day = DateFormat("dd-MM-yyyy");
    var hour = DateFormat("hh:mm a");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Chi tiết phiếu vào đã đăng ký",
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.DRIVER_PAGE);
            },
            icon: Icon(
              Icons.home,
              size: 25,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GetBuilder<RegisterDetailsDriverController>(
          init: RegisterDetailsDriverController(),
          builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                _buildDayTime(
                    controller.detailsTicker.value, size, day, hour, context),
                const SizedBox(height: 10),
                _buildNumberCar(controller.detailsTicker.value, size, context),
                const SizedBox(height: 10),
                _buildProduct(controller.detailsTicker.value, size, context),
                const SizedBox(height: 10),
                controller.detailsTicker.value.loaixe == "tai"
                    ? _buildProductCar(
                        controller.detailsTicker.value, size, context)
                    : _buildProductCont(
                        controller.detailsTicker.value, size, context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildProduct(
    RegisterForDriverModel items, Size size, BuildContext context) {
  return Card(
    child: Container(
      height: size.width * 0.1,
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
          const Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Loại hàng",
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
                items.maloaiHang == "HN" ? "Hàng nhập" : "Hàng xuất",
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColorLight),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildDayTime(RegisterForDriverModel items, Size size, DateFormat day,
    DateFormat hour, BuildContext context) {
  return Card(
    child: Container(
      height: size.width * 0.15,
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
              children: [
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Ngày dự kiến",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      day.format(DateTime.parse(items.giodukien!)),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColorLight,
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
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Giờ dự kiến",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      hour.format(DateTime.parse(items.giodukien!)),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColorLight,
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

Widget _buildProductCar(
    RegisterForDriverModel items, Size size, BuildContext context) {
  return Card(
    child: Container(
      height: size.width * 0.5,
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
                        "Số seal",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${items.cont1seal1}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Số Kiện : ",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${items.soKien}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Số Book : ",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${items.soBook}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Số Khối : ",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${items.sokhoi}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
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
    ),
  );
}

Widget _buildProductCont(
    RegisterForDriverModel items, Size size, BuildContext context) {
  return Card(
    child: Container(
      height: size.width * 0.7,
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
                        style: CustomTextStyle.titlePrimary,
                      ),
                      Text(
                        "${items.socont1}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Số seal 1",
                              style: CustomTextStyle.titlePrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${items.cont1seal1}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Số seal 2",
                              style: CustomTextStyle.titlePrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${items.cont1seal2}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Số Kiện",
                              style: CustomTextStyle.titlePrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${items.soKien}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Số Book",
                              style: CustomTextStyle.titlePrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${items.soBook}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Số Khối",
                              style: CustomTextStyle.titlePrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${items.sokhoi}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
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
          // const VerticalDivider(
          //   width: 1,
          //   indent: 15,
          //   endIndent: 15,
          //   color: Colors.orangeAccent,
          //   thickness: 1,
          // ),
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
                        style: CustomTextStyle.titlePrimary,
                      ),
                      Text("${items.socont2}"),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Số seal 1",
                              style: CustomTextStyle.titlePrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${items.cont2seal1}"),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Số seal 2",
                              style: CustomTextStyle.titlePrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${items.cont2seal2}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Số Kiện",
                              style: CustomTextStyle.titlePrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${items.sokien1}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Số Book",
                              style: CustomTextStyle.titlePrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${items.soBook1}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Số Khối",
                              style: CustomTextStyle.titlePrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${items.sokhoi1}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
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
    ),
  );
}

Widget _buildNumberCar(
    RegisterForDriverModel items, Size size, BuildContext context) {
  return Card(
    child: Container(
      height: size.width * 0.15,
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
              children: [
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Loại xe",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "${items.loaixe}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColorLight,
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
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Số xe",
                      style: TextStyle(
                        color: Colors.green,
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
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColorLight,
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
