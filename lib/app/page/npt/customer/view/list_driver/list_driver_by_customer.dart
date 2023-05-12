import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/widget/custom_list_title.dart';

import 'package:tbs_logistics_tms/app/page/npt/customer/controller/customer_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/model/list_driver_by_customer_model.dart';

class ListDriverByCustomer extends StatefulWidget {
  const ListDriverByCustomer({Key? key}) : super(key: key);

  @override
  State<ListDriverByCustomer> createState() => _ListDriverByCustomerState();
}

class _ListDriverByCustomerState extends State<ListDriverByCustomer> {
  final String routes = "/LIST_DRIVER_BY_CUSTOMER";
  var controller = Get.put(CustomerController());
  @override
  void initState() {
    controller.getListCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
      init: CustomerController(),
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
                child: FutureBuilder(
                    future: controller.getListCustomer(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var items =
                            snapshot.data as List<ListDriverByCustomerModel>;
                        return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  controller.postInforDriver(
                                      idTaixe: items[index].maTaixe);
                                },
                                child: CustomListTitle(
                                  Stt: "${index + 1}",
                                  nameDriver: "${items[index].tenTaixe}",
                                  numberPhone: "${items[index].phone}",
                                  customer: "${items[index].diaChi}",
                                  status: items[index].status!,
                                ),
                              );
                            });
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: CustomColor.borderColor,
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
