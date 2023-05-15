import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/widget/custom_list_title.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_driver_of_customer/controller/customer_list_driver_of_customer_controller.dart';

class CustomerListDriverOfCustomerScreen
    extends GetView<CustomerListDriverOfCustomerController> {
  const CustomerListDriverOfCustomerScreen({super.key});
  final String routes = "/LIST_DRIVER_BY_CUSTOMER";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerListDriverOfCustomerController>(
      init: CustomerListDriverOfCustomerController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Danh sách tài xế",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.listDriver.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.postInforDriver(
                              idTaixe: controller.listDriver[index].maTaixe);
                        },
                        child: CustomListTitle(
                          Stt: "${index + 1}",
                          nameDriver:
                              "${controller.listDriver[index].tenTaixe}",
                          numberPhone: "${controller.listDriver[index].phone}",
                          // customer: "${controller.listDriver[index].diaChi}",
                          customer: "",
                          status: controller.listDriver[index].status!,
                        ),
                      );
                    },
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
