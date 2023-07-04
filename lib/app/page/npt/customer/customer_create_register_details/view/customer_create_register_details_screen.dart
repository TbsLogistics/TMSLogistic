import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register_details/controller/customer_create_register_details_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_register_for_driver_model.dart';

class CustomerRegisterDetailScreen
    extends GetView<CustomerRegisterDetailsController> {
  const CustomerRegisterDetailScreen({super.key});
  final String routes = "/DETAILS_REGISTER_CUSTOMER";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var day = DateFormat("dd-MM-yyyy");
    var hour = DateFormat("hh:mm a");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết phiếu",
          style: CustomTextStyle.tilteAppbar,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: CustomColor.backgroundAppbar,
        actions: [
          IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.CUSTOMER_PAGE);
            },
            icon: const Icon(
              Icons.home,
              size: 25,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: GetBuilder(
        init: CustomerRegisterDetailsController(),
        builder: (controller) => Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                children: [
                  _buildDayTime(
                      controller.detailsTicker.value, size, day, hour, context),
                  _buildNumberCar(
                    items: controller.detailsTicker.value,
                    size: size,
                    context: context,
                    content: controller.detailsTicker.value.loaixe == "tai"
                        ? "Xe tải"
                        : "Xe container",
                    title: 'Loại xe',
                    title2: 'Số xe',
                    content2: controller.detailsTicker.value.soxe.toString(),
                  ),
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
                  _buildCustomer(controller.detailsTicker.value, size, context),
                  Divider(
                    indent: size.width * 0.15,
                    endIndent: size.width * 0.15,
                    height: 2,
                    thickness: 2,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  const SizedBox(height: 10),
                  controller.detailsTicker.value.loaixe == "tai"
                      ? _buildProductCar(
                          controller.detailsTicker.value, size, context)
                      : _buildProductCont(controller.detailsTicker.value, size,
                          context, controller),
                  // _buildNumberCont(
                  //     controller.detailsTicker.value, size, context),
                  _qrImage(controller, size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _qrImage(CustomerRegisterDetailsController controller, Size size) {
    return Column(
      children: [
        Card(
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: RepaintBoundary(
                key: controller.qrKey,
                child: Obx(
                  () => QrImage(
                    backgroundColor: Colors.white,
                    data:
                        "${controller.id.value},${controller.detailsTicker.value.maTaixe}",
                    version: QrVersions.auto,
                    size: size.width * 0.4,
                    embeddedImage: const AssetImage('assets/images/asd.jpg'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: const Size.square(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Card(
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
    );
  }

  Widget _buildProductCar(
      RegisterModel items, Size size, BuildContext context) {
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
        height: size.width * 0.4,
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
                                "Kg/ CBM/ Số Kiện :",
                                style: CustomTextStyle.titleDetails,
                              ),
                              Expanded(
                                child: Text(
                                  " ${items.soTan}/ ${items.sokhoi}/ ${items.soKien}",
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
      CustomerRegisterDetailsController controller) {
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
            items.loaiCont != null
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
                                          color: Theme.of(context)
                                              .primaryColorLight,
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
            items.loaiCont1 != null
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
                                          color: Theme.of(context)
                                              .primaryColorLight,
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

  Widget _buildCustomer(RegisterModel items, Size size, BuildContext context) {
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

  Widget _buildDayTime(RegisterModel items, Size size, DateFormat day,
      DateFormat hour, BuildContext context) {
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
}
