import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
// import 'package:tbs_logistics_tms/app/config/data/text_style.dart';

// import 'package:tbs_logistics_tms/app/config/data/color.';
// import 'package:tbs_logistics_tms/app/config/widget/custom_text_form_field.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/controller/sercurity_list_dangtai_controller.dart';
// import 'package:tbs_logistics_tms/app/page/npt/sercurity/model/detail_entry_vote_model.dart';
// import 'package:tbs_logistics_tms/app/page/npt/sercurity/modules/security_car_in_screen.dart';
// import 'package:tbs_logistics_tms/app/page/npt/sercurity/modules/security_car_out_screen.dart';

class SercurityListDangTaiScreen
    extends GetView<SercurityListDangTaiController> {
  const SercurityListDangTaiScreen({super.key});

  final String routes = "/SERCURITY_LIST_DANGTAI";

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
      body: GetBuilder<SercurityListDangTaiController>(
        init: SercurityListDangTaiController(),
        builder: (controller) => Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ListView.builder(
              itemBuilder: (c, i) {
                var items = controller.listDangtai[i];
                return _customListTitle(
                  stt: "${i + 1}",
                  nameDriver: '${items.maTaixe!.tenTaixe}',
                  CCCD: '${items.maTaixe!.cCCD}',
                  soCont: '${items.socont1}',
                  numberCar: '${items.soxe}',
                  time: hours.format(
                    DateTime.parse("${items.giodukien}"),
                  ),
                  onTap: () {
                    Get.toNamed(
                      Routes.SERCURITY_DETAILS_LIST_DANGTAI,
                      arguments: items,
                    );
                  },
                );
              },
              itemCount: controller.listDangtai.length,
            ),
          ),
        ),
      ),
    );
  }

  Widget _customListTitle({
    required String stt,
    required String nameDriver,
    required String CCCD,
    required String soCont,
    required String numberCar,
    required String time,
    Function()? onTap,
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
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                        child: Text(
                      stt,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              nameDriver,
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              CCCD,
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Số Cont: ",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              soCont,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Số xe :",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              numberCar,
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Giờ dự kiến :",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              time,
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
