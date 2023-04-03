import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/tms/controller/tms_finished_controller.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';

// ignore: must_be_immutable
class TmsFinished extends GetView<TmsFinishedController> {
  const TmsFinished({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TmsFinishedController>(
      init: TmsFinishedController(),
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
                          initiallyExpanded: true,
                          title: const Text(
                            '',
                            style: TextStyle(color: Colors.green),
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
                                title:
                                    Text('${controller.listOrder[i].maChuyen}'),
                                trailing: SizedBox(
                                  width: 50,
                                  height: 30,
                                  // color: Colors.green,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${controller.listOrder[i].maPTVC}',
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
