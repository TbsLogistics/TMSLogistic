import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/widget/custom_list_title.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_finished/controller/driver_finished_controller.dart';

import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_finished/model/list_tiker_for_driver.dart';

class DriverFinishedScreen extends GetView<DriverFinishedController> {
  const DriverFinishedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var day = DateFormat("dd/MM/yyyy");
    return GetBuilder<DriverFinishedController>(
      init: DriverFinishedController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Danh sách phiếu đã đăng ký",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).primaryColorLight,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: FutureBuilder(
            future: controller.getListTiker(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var items = snapshot.data as List<ListTicketForDriver>;
                // print(items);
                return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            Routes.STATUS_TICKER_DETAIL_SCREEN,
                            arguments: items[index],
                          );
                        },
                        child: CustomListTitle(
                          Stt: "${index + 1}",
                          nameDriver: "${items[index].phieuvao!.soxe}",
                          numberPhone: day.format(
                            DateTime.parse(
                              items[index].giovao.toString(),
                            ),
                          ),
                          customer: "",
                          status: items[index].status == true,
                        ),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(
                    color: CustomColor.backgroundAppbar),
              );
            }),
      ),
    );
  }
}
