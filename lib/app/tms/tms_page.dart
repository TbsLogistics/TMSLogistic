import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tbs_logistics_tms/app/tms/modules/drawer.dart';

import 'package:tbs_logistics_tms/app/tms/view/tms_finished.dart';
import 'package:tbs_logistics_tms/app/tms/view/tms_pending.dart';
import 'package:tbs_logistics_tms/app/tms/view/tms_working.dart';

import 'package:tbs_logistics_tms/config/core/data/color.dart';

import 'package:tbs_logistics_tms/app/tms/controller/tms_controller.dart';

class TmsPage extends GetView<TmsController> {
  const TmsPage({super.key});

  final String routes = "/TMS_PAGE";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent app from exiting
        return false;
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Trang chủ"),
            centerTitle: true,
            backgroundColor: CustomColor.backgroundAppbar,
          ),
          drawer: const DrawerScreen(),
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
                        TmsWorking(),
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
