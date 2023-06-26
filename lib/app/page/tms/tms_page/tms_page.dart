import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/tms/finished/view/finished_screen.dart';
import 'package:tbs_logistics_tms/app/page/tms/pending/view/pending_screen.dart';
import 'package:tbs_logistics_tms/app/page/tms/tms_page/controller/tms_controller.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait/view/wait_screen.dart';

import '../../../config/data/color.dart';

class TmsPage extends GetView<TmsController> {
  const TmsPage({super.key});

  final String routes = "/TMS_PAGE";

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent app from exiting
        return false;
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 24,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.dashboard_customize,
                  size: 24,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.toNamed(Routes.DASH_BOARD_PAGE);
                },
              ),
            ],
            title: const Text("TMS PAGE"),
            centerTitle: true,
            backgroundColor: CustomColor.backgroundAppbar,
          ),
          body: GetBuilder<TmsController>(
            init: TmsController(),
            builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: controller.controller,
                      children: const [
                        TmsAwait(),
                        TmsPending(),
                        TmsFinished(),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                      controller: controller.controller,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: Colors.orangeAccent.shade200,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: controller.myTabs,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
