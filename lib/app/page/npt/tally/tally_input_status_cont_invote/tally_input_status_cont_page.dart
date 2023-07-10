import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/page/npt/tally/tally_input_status_cont_invote/controller/tally_input_status_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/tally/widgets/tally_button_submit.dart';
import 'package:tbs_logistics_tms/app/page/npt/tally/widgets/tally_custom_textfield.dart';

class TallyInputStatusPgae extends GetView<TallyInputStatusController> {
  const TallyInputStatusPgae({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<TallyInputStatusController>(
      init: TallyInputStatusController(),
      builder: (controller) => Scaffold(
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
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TallyCustomFormFiels(
                  controller: controller.contCarController,
                  hintText: "",
                  color: Colors.green,
                  title: "",
                ),
                SizedBox(height: size.height * 0.1),
                TallyButtonFormSubmit(
                  width: 150,
                  onPressed: () {},
                  text: "Xác nhận",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
