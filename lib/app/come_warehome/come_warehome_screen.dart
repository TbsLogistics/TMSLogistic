import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/modules/camera_screen.dart';
import 'package:tbs_logistics_tms/app/surcharges/surcharges_screen.dart';
import 'package:tbs_logistics_tms/config/core/data/color.dart';
import 'package:tbs_logistics_tms/app/come_warehome/controller/come_warehome_controller.dart';
import 'package:tbs_logistics_tms/config/widget/button_status.dart';

// ignore: must_be_immutable
class ComeWareHomeScreen extends GetView<ComeWareHomeController> {
  ComeWareHomeScreen({super.key});
  String address = "Suối tiên";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết chuyến"),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        backgroundColor: CustomColor.backgroundAppbar,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: GetBuilder<ComeWareHomeController>(
        init: ComeWareHomeController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.orangeAccent,
              ),
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  title: const Text('ICD Phú Xuân'),
                  trailing: SizedBox(
                    width: 250,
                    height: 40,
                    // color: Colors.green,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            address,
                            style: const TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              controller.openGoogleMap(address);
                            },
                            icon: const Icon(
                              Icons.map_outlined,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (ctx, i) {
                      return ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                          'Đơn hàng ${i + 1}',
                          style: TextStyle(color: Colors.green),
                        ),
                        trailing: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            // Get.to(() => StartDetailTms());
                          },
                          child: const Text(
                            'Chờ xử lí',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.upload_sharp),
                            title: Text('ICD TBSL'),
                            trailing: Text(
                              "BOOKING: 123",
                            ),
                          ),
                          const ListTile(
                            leading: Icon(Icons.download),
                            title: Text('Cát Lái'),
                            trailing: Text(
                              "14/03/2023 lúc 15:00",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: size.width * 0.93,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ButtonStatus(
                                  text: "Chụp chứng từ",
                                  onPressed: () {
                                    Get.to(() => CameraScreen());
                                  },
                                ),
                                ButtonStatus(
                                  text: "Phụ thu",
                                  onPressed: () {
                                    Get.to(() => SurChangesScreen());
                                  },
                                ),
                                ButtonStatus(
                                  text: "Đã tới kho",
                                  onPressed: () {
                                    print("Đã tới kho");
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                        onExpansionChanged: (bool expanded) {
                          // setState(() => _customTileExpanded = expanded);
                        },
                      );
                    },
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
