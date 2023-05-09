import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/tms/surcharges/controller/surchanges_controller.dart';

class ListAddScreen extends StatelessWidget {
  const ListAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SurChangesController>(
      init: SurChangesController(),
      builder: (controller) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Danh sách phụ phí đã thêm",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Obx(() => Container(
                height: 90 * double.parse(controller.listSur.length.toString()),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.listSur.length,
                  itemBuilder: (ctx, i) {
                    return Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Colors.orangeAccent, width: 1),
                      ),
                      child: ListTile(
                        title: Text(
                          "${controller.listSur[i].sfName}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          " ${NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0).format(controller.listSur[i].finalPrice)}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}
