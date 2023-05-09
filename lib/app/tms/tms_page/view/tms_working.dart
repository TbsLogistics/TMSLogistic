import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/tms/tms_page/controller/tms_working_controller.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';

class TmsWorking extends GetView<TmsWorkingController> {
  const TmsWorking({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TmsWorkingController>(
      init: TmsWorkingController(),
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(
            () {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.listOrder.length,
                  itemBuilder: (ctx, i) {
                    return controller.listOrder[i].getDataHandlingMobiles![0]
                                .trangThai ==
                            "Chờ Vận Chuyển"
                        ? ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              '${controller.listOrder[i].maChuyen}',
                              style: const TextStyle(color: Colors.green),
                            ),
                            trailing: TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () async {
                                var result = await Get.toNamed(
                                  Routes.START_DETAIL_TMS,
                                  arguments: controller.listOrder[i],
                                );
                                if (result is bool && result == true) {
                                  controller.getData();
                                }
                              },
                              child: const Text(
                                'Xem chi tiết !',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            children: <Widget>[
                              ListTile(
                                  title: const Text(''),
                                  trailing: SizedBox(
                                    width: 80,
                                    height: 30,
                                    // color: Colors.green,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${controller.listOrder[i].loaiPhuongTien}',
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                            onExpansionChanged: (bool expanded) {
                              // setState(() => _customTileExpanded = expanded);
                            },
                          )
                        : Container();
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
