import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager_details/controller/letter_manager_details_controller.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager_details_access/view/letter_manager_details_access_screen.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager_details_see/view/letter_manager_details_see.dart';

import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';

class LetterManagerDetailsScreen
    extends GetView<LetterManagerDetailsController> {
  const LetterManagerDetailsScreen({super.key});

  final String routes = "/DETAIL_ACCESS_SINGLE_SCREEN";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (Get.arguments != null && Get.arguments is int) {
      var regId = Get.arguments;
      return GetBuilder<LetterManagerDetailsController>(
          init: LetterManagerDetailsController(),
          builder: (controller) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
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
                              LetterManagerDetailsSee(regId),
                              // ignore: unrelated_type_equality_checks
                              LetterManagerDetailsAccess(regId),
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
    return Container();
  }
}
