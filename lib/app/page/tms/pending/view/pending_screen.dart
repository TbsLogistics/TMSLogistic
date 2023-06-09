import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/tms/pending/controller/pending_controller.dart';

class TmsPending extends GetView<PendingController> {
  const TmsPending({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container();
    return GetBuilder<PendingController>(
      init: PendingController(),
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() {
            return Expanded(
              child: controller.isLoad.value
                  ? ListView.builder(
                      itemCount: controller.listOrder.length,
                      itemBuilder: (ctx, i) {
                        return controller.listOrder[i]
                                        .getDataHandlingMobiles![0].trangThai !=
                                    "Chờ Vận Chuyển" &&
                                controller
                                        .listOrder[i]
                                        .getDataHandlingMobiles![0]
                                        .maTrangThai !=
                                    20
                            ? ExpansionTile(
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
                                      Routes.PENDING_DETAIL_TMS,
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
                                        width: 100,
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
