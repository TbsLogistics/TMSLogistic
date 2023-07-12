// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait_details/controller/wait_details_controller.dart';

class AwaitDetails extends GetView<AwaitDetailsController> {
  const AwaitDetails({super.key});
  final String routes = "/START_DETAIL_TMS";

  @override
  Widget build(BuildContext context) {
    var day = DateFormat("dd-MM-yyyy");
    var hour = DateFormat("hh:mm a");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Chi tiết chuyến"),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        backgroundColor: CustomColor.backgroundAppbar,
        leading: IconButton(
          onPressed: () {
            Get.back(result: true);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: GetBuilder<AwaitDetailsController>(
        init: AwaitDetailsController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orangeAccent),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      controller.postSetRuning(
                        id: controller.detailOrder.value
                            .getDataHandlingMobiles![0].handlingId!,
                      );
                    },
                    child: const Text(
                      "Bắt đầu chuyến",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.listReceiveEmpty[0] != ""
                          ? _receiveEmptyPlace()
                          : Container(),
                      controller.listReceive[0] != ""
                          ? _receivePlace()
                          : Container(),
                      controller.listGive[0] != "" ? _givePlace() : Container(),
                      controller.listGiveEmpty[0] != ""
                          ? _giveEmptyPlace()
                          : Container(),
                    ],
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _receiveEmptyPlace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
          child: Text(
            "Điểm lấy rỗng :",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 60 * double.parse("${controller.listReceiveEmpty.length}"),
          child: ListView.builder(
            itemCount: controller.listReceiveEmpty.length,
            itemBuilder: (_, i) {
              return _customeListTitle(
                content: "${controller.listReceiveEmpty[i]}",
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _receivePlace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
          child: Text(
            "Điểm lấy hàng :",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 60 * double.parse("${controller.listReceive.length}"),
          child: ListView.builder(
            itemCount: controller.listReceive.length,
            itemBuilder: (_, i) {
              return _customeListTitle(
                content: "${controller.listReceive[i]}",
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _giveEmptyPlace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
          child: Text(
            "Điểm trả hàng :",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 60 * double.parse("${controller.listGiveEmpty.length}"),
          child: ListView.builder(
            itemCount: controller.listGiveEmpty.length,
            itemBuilder: (_, i) {
              return _customeListTitle(
                content: "${controller.listGiveEmpty[i]}",
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _givePlace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
          child: Text(
            "Điểm trả rỗng :",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 60 * double.parse("${controller.listGive.length}"),
          child: ListView.builder(
            itemCount: controller.listGive.length,
            itemBuilder: (_, i) {
              return _customeListTitle(
                content: "${controller.listGive[i]}",
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _customeListTitle({required String content}) {
    return Container(
      height: 55,
      child: Card(
        shadowColor: Colors.amberAccent,
        shape: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orangeAccent,
            width: 1,
          ),
        ),
        borderOnForeground: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_border,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      content,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
