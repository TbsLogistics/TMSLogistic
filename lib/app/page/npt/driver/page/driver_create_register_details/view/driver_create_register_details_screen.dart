import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/register_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register_details/controller/driver_create_register_details_controller.dart';

class DriverCreateRegisterDetailsScreen
    extends GetView<DriverCreateRegisterDetailsController> {
  const DriverCreateRegisterDetailsScreen({super.key});

  final String routes = "/DETAILS_FORM_REGISTER_DRIVER";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var day = DateFormat("dd-MM-yyyy");
    var hour = DateFormat("hh:mm a");
    return GetBuilder<DriverCreateRegisterDetailsController>(
      init: DriverCreateRegisterDetailsController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Chi tiết phiếu",
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                _buildDayTime(
                    controller.detailsTicker.value, size, day, hour, context),

                //Loại hàng + Kho
                _buildNumberCar(
                  items: controller.detailsTicker.value,
                  size: size,
                  context: context,
                  content: controller.detailsTicker.value.maloaiHang == "HN"
                      ? "Hàng nhập"
                      : "Hàng xuất",
                  title: 'Loại Hàng',
                  title2: 'Kho',
                  content2: controller.detailsTicker.value.kho.toString(),
                ),
                // const SizedBox(height: 10),

                _buildCustomer(
                    controller.detailsTicker.value, size, context, controller),
                const SizedBox(height: 10),
                controller.detailsTicker.value.loaixe == "tai"
                    ? _buildProductCar(
                        controller.detailsTicker.value, size, context)
                    : controller.numberCont.value != 0
                        ? _buildProductCont(controller.detailsTicker.value,
                            size, context, controller)
                        : Container(),
                const SizedBox(height: 10),
                _qrImage(controller, size),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _qrImage(DriverCreateRegisterDetailsController controller, Size size) {
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
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: RepaintBoundary(
              key: controller.qrDriverKey,
              child: Obx(() {
                return QrImage(
                  backgroundColor: Colors.white,
                  data: controller.id.value,
                  version: QrVersions.auto,
                  size: size.width * 0.4,
                );
              }),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: Text(
              controller.id.value,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          height: 40,
          width: 200,
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
              "Share Qr Code",
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

Widget _buildNumberCar(
    {required RegisterModel items,
    required Size size,
    required BuildContext context,
    required String title,
    required String content,
    required String title2,
    required String content2}) {
  return Card(
    shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.orangeAccent)),
    shadowColor: Colors.grey,
    elevation: 10,
    child: SizedBox(
      height: size.width * 0.15,
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
                      title,
                      style: CustomTextStyle.titleDetails,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      content,
                      style: CustomTextStyle.contentDetails,
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
                      title2,
                      style: CustomTextStyle.titleDetails,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      content2,
                      style: CustomTextStyle.contentDetails,
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

Widget _buildCustomer(RegisterModel items, Size size, BuildContext context,
    DriverCreateRegisterDetailsController controller) {
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Khách hàng",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                controller.nameCustomer.value,
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

Widget _buildDayTime(RegisterModel items, Size size, DateFormat day,
    DateFormat hour, BuildContext context) {
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
                      style: CustomTextStyle.titleDetails,
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
                      style: CustomTextStyle.titleDetails,
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

Widget _buildProductCar(RegisterModel items, Size size, BuildContext context) {
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
    child: Container(
      height: size.width * 0.6,
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
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Số seal",
                        style: CustomTextStyle.titleDetails,
                      ),
                      const SizedBox(
                        height: 10,
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
                const SizedBox(
                  height: 10,
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
                              style: CustomTextStyle.titleDetails,
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [],
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
                              "Số Kiện :",
                              style: CustomTextStyle.titleDetails,
                            ),
                            Expanded(
                              child: Text(
                                "${items.soKien}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorLight,
                                ),
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
                              "Số khối (CBM):",
                              style: CustomTextStyle.titleDetails,
                            ),
                            Expanded(
                              child: Text(
                                "${items.sokhoi}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorLight,
                                ),
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
                              "Kg :",
                              style: CustomTextStyle.titleDetails,
                            ),
                            Expanded(
                              child: Text(
                                "${items.soTan}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorLight,
                                ),
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

Widget _buildProductCont(RegisterModel items, Size size, BuildContext context,
    DriverCreateRegisterDetailsController controller) {
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
    child: Container(
      height: size.width * 0.6,
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
          controller.numberCont.value >= 1
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Số cont 1",
                              style: CustomTextStyle.titleDetails,
                            ),
                            Text(
                              "${items.socont1}",
                              style: CustomTextStyle.contentDetails,
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
                                    style: CustomTextStyle.titleDetails,
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
                                      color:
                                          Theme.of(context).primaryColorLight,
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Số seal 2",
                                    style: CustomTextStyle.titleDetails,
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
                                      color:
                                          Theme.of(context).primaryColorLight,
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Số Book",
                                    style: CustomTextStyle.titleDetails,
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
                                      color:
                                          Theme.of(context).primaryColorLight,
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kg/ CBM/ Số Kiện",
                                    style: CustomTextStyle.titleDetails,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${items.soTan}/${items.sokhoi}/${items.soKien}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
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
                )
              : Container(),
          const VerticalDivider(
            width: 1,
            indent: 15,
            endIndent: 15,
            color: Colors.orangeAccent,
            thickness: 1,
          ),
          controller.numberCont.value == 2
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Số cont 2",
                              style: CustomTextStyle.titleDetails,
                            ),
                            Text(
                              "${items.socont2}",
                              style: CustomTextStyle.contentDetails,
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
                                    style: CustomTextStyle.titleDetails,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${items.cont2seal1}",
                                    style: CustomTextStyle.contentDetails,
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
                                    style: CustomTextStyle.titleDetails,
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
                                      color:
                                          Theme.of(context).primaryColorLight,
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Số Book",
                                    style: CustomTextStyle.titleDetails,
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
                                      color:
                                          Theme.of(context).primaryColorLight,
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kg/ CBM/ Số Kiện",
                                    style: CustomTextStyle.titleDetails,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${items.soTan1}/${items.sokhoi1}/${items.sokien1}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
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
                )
              : Container(),
        ],
      ),
    ),
  );
}

Widget _buildNumberCont(DriverCreateRegisterDetailsController items, Size size,
    BuildContext context) {
  var itemsCont = items.detailsTicker.value;
  return Container(
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
            ],
          ),
        ),
      ],
    ),
  );
}

// Widget _buildNumberCar(
//     RegisterModel items, Size size, BuildContext context) {
//   return Card(
//     shadowColor: Colors.grey,
//     elevation: 10,
//     shape: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(15),
//       borderSide: const BorderSide(
//         color: Colors.orangeAccent,
//         width: 1,
//       ),
//     ),
//     child: Container(
//       height: size.width * 0.15,
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 1,
//           color: Colors.orangeAccent,
//         ),
//         borderRadius: BorderRadius.circular(15),
//         // color: Colors.white,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 const Expanded(
//                   flex: 2,
//                   child: Center(
//                     child: Text(
//                       "Loại xe",
//                       style: CustomTextStyle.titleDetails,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Center(
//                     child: Text(
//                       items.loaixe == "tai" ? "Xe tải" : "Xe cont",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Theme.of(context).primaryColorLight,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const VerticalDivider(
//             width: 1,
//             indent: 10,
//             endIndent: 10,
//             color: Colors.orangeAccent,
//             thickness: 1,
//           ),
//           Expanded(
//             child: Column(
//               children: [
//                 const Expanded(
//                   flex: 2,
//                   child: Center(
//                     child: Text(
//                       "Số xe",
//                       style: CustomTextStyle.titleDetails,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Center(
//                     child: Text(
//                       "${items.soxe}",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Theme.of(context).primaryColorLight,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
