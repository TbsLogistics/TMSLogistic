import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create/controller/letter_myself_create_controller.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create_access/view/letter_myself_create_access_screen.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create_sent/view/letter_myself_create_sent_screen.dart';

class LetterMyselfCreateScreen extends GetView<LetterMyselfCreateController> {
  const LetterMyselfCreateScreen({super.key});
  final String routes = "/CREATE_LEAVE_FORM_PAGE";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<LetterMyselfCreateController>(
        init: LetterMyselfCreateController(),
        builder: (controller) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text(
                  "Quản lý đơn nghỉ phép",
                  style: CustomTextStyle.tilteAppbar,
                ),
                backgroundColor: CustomColor.backgroundAppbar,
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
                  height: size.height,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                        ),
                        child: TabBar(
                          controller: controller.tabController,
                          // give the indicator a decoration (color and border radius)
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                            color: Colors.orangeAccent.shade200,
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          tabs: controller.tabCreate,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: TabBarView(
                          controller: controller.tabController,
                          children: [
                            const LetterMyselfCreateSentScreen(),
                            // ignore: unrelated_type_equality_checks

                            LetterMyselfCreateAccessScreen()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
