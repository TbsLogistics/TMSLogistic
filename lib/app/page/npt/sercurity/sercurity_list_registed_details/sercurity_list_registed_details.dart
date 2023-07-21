import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_list_registed_details/controller/sercurity_list_registed_details_controller.dart';

class SercurityDetailsListDangTaiScreen
    extends GetView<SercurityListRegistedDetailController> {
  const SercurityDetailsListDangTaiScreen({super.key});

  final String routes = "/SERCURITY_DETAILS_LIST_DANGTAI";

  @override
  Widget build(BuildContext context) {
    var hours = DateFormat('dd-MM-yyyy HH:mm a');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.backgroundAppbar,
        title: const Text(
          "Danh sách đăng tài",
          style: CustomTextStyle.tilteAppbar,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
      ),
      body: GetBuilder<SercurityListRegistedDetailController>(
        init: SercurityListRegistedDetailController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                formInfo(
                  title1: 'Tên tài xế',
                  content1: controller.items.value.maTaixe!.tenTaixe ?? "",
                  title2: 'CCCD',
                  content2: controller.items.value.maTaixe!.cCCD ?? "",
                ),
                formInfo(
                  title1: 'Số điện thoại tài xế',
                  content1: controller.items.value.maTaixe!.phone ?? "",
                  title2: 'Khách hàng',
                  content2:
                      controller.items.value.maKhachHang!.tenKhachhang ?? "",
                ),
                formInfo(
                  title1: 'Số xe',
                  content1: controller.items.value.soxe ?? "",
                  title2: 'Loại xe',
                  content2: controller.items.value.loaixe!.tenLoaiXe ?? "",
                ),
                formInfo(
                  title1: 'Giờ dự kiện',
                  content1: hours.format(
                    DateTime.parse("${controller.items.value.giodukien}"),
                  ),
                  title2: 'Kho',
                  content2: controller.items.value.khoRe!.tenKho ?? "",
                ),
                controller.items.value.loaixe!.maLoaiXe == "con"
                    ? Column(
                        children: [
                          formCont(
                            cont: controller.items.value.socont1 ?? "",
                            seal1: controller.items.value.cont1seal1 ?? "",
                            seal2: controller.items.value.cont1seal2 ?? "",
                            typeCont:
                                controller.items.value.loaiCont!.typeContname ??
                                    "",
                            soBook: controller.items.value.soBook ?? "",
                            soKien: controller.items.value.soKien ?? 0.0,
                            CBM: controller.items.value.sokhoi ?? 0.0,
                            Kg: controller.items.value.soTan ?? 0.0,
                          ),
                          controller.items.value.loaiCont1!.typeContCode != null
                              ? formCont(
                                  cont: controller.items.value.socont2 ?? "",
                                  seal1:
                                      controller.items.value.cont2seal1 ?? "",
                                  seal2:
                                      controller.items.value.cont2seal2 ?? "",
                                  typeCont: controller.items.value.loaiCont1!
                                          .typeContname ??
                                      "",
                                  soBook: controller.items.value.soBook1 ?? "",
                                  soKien: controller.items.value.sokien1 ?? 0.0,
                                  CBM: controller.items.value.sokhoi1 ?? 0.0,
                                  Kg: controller.items.value.soTan1 ?? 0.0,
                                )
                              : Container(),
                        ],
                      )
                    : formCar(
                        seal: controller.items.value.cont1seal1 ?? "",
                        soBook: controller.items.value.cont1seal2 ?? "",
                        soKien: controller.items.value.soKien ?? 0.0,
                        CBM: controller.items.value.sokhoi ?? 0.0,
                        Kg: controller.items.value.soTan ?? 0.0,
                        size: MediaQuery.of(context).size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formInfo({
    required String title1,
    required String title2,
    required String content1,
    required String content2,
  }) {
    return Card(
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          width: 1,
          color: Colors.orangeAccent,
        ),
      ),
      shadowColor: Colors.grey,
      elevation: 10,
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title1,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    content1,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title2,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    content2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
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

  Widget formCont({
    required String cont,
    required String seal1,
    required String seal2,
    required String soBook,
    required double soKien,
    required double CBM,
    required double Kg,
    required String typeCont,
  }) {
    return Card(
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          width: 1,
          color: Colors.orangeAccent,
        ),
      ),
      shadowColor: Colors.grey,
      elevation: 10,
      child: Container(
        height: 220,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Số Cont/ $typeCont",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    cont,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Số seal",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    seal1,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Số seal",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    seal2,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Số Book",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    soBook,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Số Kiện/ CBM/ Kg",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${soKien} /${CBM} /${Kg}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formCar({
    required String seal,
    required String soBook,
    required double soKien,
    required double CBM,
    required double Kg,
    required Size size,
  }) {
    return Card(
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          width: 1,
          color: Colors.orangeAccent,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          height: 130,
          width: size.width - 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Số seal",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
              Text(
                seal,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Số Book",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
              Text(
                soBook,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const Text(
                "Số Kiện/ CBM/ Kg",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
              Text(
                "${soKien} /${CBM} /${Kg}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
