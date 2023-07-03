import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/controller/sercurity_details_list_dangtai_controller.dart';

class SercurityDetailsListDangTaiScreen
    extends GetView<SercurityDetailsListDangTaiController> {
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
      body: GetBuilder<SercurityDetailsListDangTaiController>(
        init: SercurityDetailsListDangTaiController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            children: [
              formInfo(
                title1: 'Tên tài xế',
                content1: '${controller.items.value.maTaixe!.tenTaixe}',
                title2: 'CCCD',
                content2: '${controller.items.value.maTaixe!.cCCD}',
              ),
              formInfo(
                title1: 'Số điện thoại tài xế',
                content1: '${controller.items.value.maTaixe!.phone}',
                title2: 'Khách hàng',
                content2: '${controller.items.value.khachhangRe!.tenKhachhang}',
              ),
              formInfo(
                title1: 'Số xe',
                content1: '${controller.items.value.soxe}',
                title2: 'Loại xe',
                content2: '${controller.items.value.loaixe!.tenLoaiXe}',
              ),
              formInfo(
                title1: 'Giờ dự kiện',
                content1: hours.format(
                  DateTime.parse("${controller.items.value.giodukien}"),
                ),
                title2: 'Kho',
                content2: '${controller.items.value.kho!.tenKho}',
              ),
              formCont(
                cont: '${controller.items.value.socont1}',
                seal1: '${controller.items.value.cont1seal1}',
                seal2: '${controller.items.value.cont1seal2}',
                typeCont: '${controller.items.value.loaiCont!.typeContname}',
              ),
              controller.items.value.socont2 != ""
                  ? formCont(
                      cont: '${controller.items.value.socont2}',
                      seal1: '${controller.items.value.cont2seal1}',
                      seal2: '${controller.items.value.cont2seal2}',
                      typeCont:
                          '${controller.items.value.loaiCont1!.typeContname}',
                    )
                  : Container(),
            ],
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
        height: seal2 == "" ? 120 : 180,
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
                  seal2 != ""
                      ? const Text(
                          "Số seal",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        )
                      : Container(),
                  seal2 != ""
                      ? Text(
                          seal2,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
