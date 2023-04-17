import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/surcharges/controller/surchanges_controller.dart';

class ListAddedScreen extends StatelessWidget {
  const ListAddedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var day = DateFormat("dd/MM");
    var hour = DateFormat("hh-mm a");
    return GetBuilder<SurChangesController>(
      init: SurChangesController(),
      builder: (controller) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Danh sách đã phụ phí đã thêm",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => controller.isLoadListSur.value
                    ? SizedBox(
                        height: 90 *
                            double.parse(
                                controller.listSurRegisted.length.toString()),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.listSurRegisted.length,
                            itemBuilder: (ctx, i) {
                              return Card(
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      color: Colors.orangeAccent, width: 1),
                                ),
                                child: ListTile(
                                  title: Text(
                                    "${controller.listSurRegisted[i].subFee}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    " ${NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0).format(controller.listSurRegisted[i].price)}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${controller.listSurRegisted[i].trangThai}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "${day.format(DateTime.parse(controller.listSurRegisted[i].createdDate.toString()))} ${hour.format(DateTime.parse(controller.listSurRegisted[i].createdDate.toString()))}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orangeAccent,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
