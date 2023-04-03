import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/change_password/change_password.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/modules/note_pending.dart';
import 'package:tbs_logistics_tms/app/surcharges/surcharges_screen.dart';
import 'package:tbs_logistics_tms/app/tms/view/tms_finished.dart';
import 'package:tbs_logistics_tms/app/tms/view/tms_pending.dart';
import 'package:tbs_logistics_tms/app/tms/view/tms_working.dart';

import 'package:tbs_logistics_tms/config/core/data/color.dart';

import 'package:tbs_logistics_tms/app/tms/controller/tms_controller.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class TmsPage extends GetView<TmsController> {
  const TmsPage({super.key});

  final String routes = "/TMS_PAGE";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Trang chủ"),
          centerTitle: true,
          // automaticallyImplyLeading: false,
          backgroundColor: CustomColor.backgroundAppbar,
        ),
        drawer: Drawer(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      height: size.height * 0.3,
                      color: Colors.green,
                      child: const Center(
                        child: Text("Username"),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      onTap: () async {
                        await SharePerApi().postLogout();
                      },
                      title: const Text("Logout"),
                      leading: const Icon(
                        Icons.logout_outlined,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => ChangePasswordScreen());
                      },
                      title: const Text("Chang PassWord"),
                      leading: const Icon(
                        Icons.language_outlined,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                    children: [
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
    );
  }
}
