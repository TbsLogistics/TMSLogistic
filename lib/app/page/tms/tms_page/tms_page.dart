import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/tms/finished/view/finished_screen.dart';
import 'package:tbs_logistics_tms/app/page/tms/pending/view/pending_screen.dart';
import 'package:tbs_logistics_tms/app/page/tms/tms_page/controller/tms_controller.dart';
import 'package:tbs_logistics_tms/app/page/tms/tms_page/modules/custom_animated_bottom_bar.dart';
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
          length: 2,
          child: GetBuilder<TmsController>(
            init: TmsController(),
            builder: (controller) => Scaffold(
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
                title: const Text("TMS PAGE"),
                centerTitle: true,
                backgroundColor: CustomColor.backgroundAppbar,
              ),
              // body: Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Expanded(
              //         child: TabBarView(
              //           controller: controller.controller,
              //           children: const [
              //             TmsAwait(),
              //             TmsPending(),
              //             TmsFinished(),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         height: 50,
              //         decoration: BoxDecoration(
              //           color: Colors.grey[300],
              //           borderRadius: BorderRadius.circular(
              //             25.0,
              //           ),
              //         ),
              //         child: TabBar(
              //           controller: controller.controller,
              //           indicator: BoxDecoration(
              //             borderRadius: BorderRadius.circular(
              //               25.0,
              //             ),
              //             color: Colors.orangeAccent.shade200,
              //           ),
              //           labelColor: Colors.white,
              //           unselectedLabelColor: Colors.black,
              //           tabs: controller.myTabs,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                    Expanded(
                      child: TabBarView(
                        controller: controller.controller,
                        children: const [
                          TmsAwait(),
                          // TmsPending(),
                          TmsFinished(),
                        ],
                      ),
                    ),
                    Container(height: 30),
                  ],
                ),
              ),
              // bottomNavigationBar: _buildBottomBar(),
            ),
          )),
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: controller.currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) {
        controller.currentIndex = index;
        controller.update();
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.av_timer),
          title: Text('Lệnh chờ'),
          activeColor: Colors.green,
          inactiveColor: controller.inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.add_location_rounded),
          title: Text('Lệnh thực hiện'),
          activeColor: Colors.purpleAccent,
          inactiveColor: controller.inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.add_task_sharp),
          title: Text(
            'Hoàn thành ',
          ),
          activeColor: Colors.pink,
          inactiveColor: controller.inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      TmsAwait(),
      TmsPending(),
      TmsFinished(),
    ];
    return IndexedStack(
      index: controller.currentIndex,
      children: pages,
    );
  }
}
