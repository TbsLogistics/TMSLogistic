import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:tbs_logistics_tms/app/config/data/text_style.dart';

// import 'package:tbs_logistics_tms/app/config/data/color.';
// import 'package:tbs_logistics_tms/app/config/widget/custom_text_form_field.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/controller/sercurity_controller.dart';
// import 'package:tbs_logistics_tms/app/page/npt/sercurity/model/detail_entry_vote_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/modules/security_car_in_screen.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/modules/security_car_out_screen.dart';

class SercurityScreen extends GetView<SercurityController> {
  const SercurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SercurityController>(
      init: SercurityController(),
      builder: (controller) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () {
                controller.scanQr(idCode: "Vao");
              },
              icon: const Icon(Icons.qr_code_2_outlined),
              label: const Text("Quét mã"),
            ),
            Obx(
              () => controller.detailEntryVote.value.giovao == null
                  ? SercurityCarInScreen()
                  : SercurityCarOutScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
