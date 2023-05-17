import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/tms/finished/controller/finished_controller.dart';

// ignore: must_be_immutable
class TmsFinished extends GetView<FinishedController> {
  const TmsFinished({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FinishedController>(
      init: FinishedController(),
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() {
            return Expanded(
              child: controller.isLoad.value
                  ? ListView.builder(
                      itemCount: controller.listOrder.length,
                      itemBuilder: (ctx, i) {
                        return ExpansionTile(
                          initiallyExpanded: false,
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
                                Routes.FINISHED_DETAIL_TMS,
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
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orangeAccent,
                      ),
                    ),
            );
          })
        ],
      ),
    );
  }
}
