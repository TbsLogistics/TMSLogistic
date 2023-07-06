import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_ticker_registed/controller/customer_list_ticker_registed_controller.dart';

class CustomerListTickerRegisted
    extends GetView<CustomerListTickerRegistedController> {
  final String routes = "/LIST_TICKER_CUSTOMER";

  const CustomerListTickerRegisted({super.key});
  @override
  Widget build(BuildContext context) {
    var day = DateFormat("dd-MM-yyyy");
    var hour = DateFormat("hh-mm a");
    return GetBuilder<CustomerListTickerRegistedController>(
      init: CustomerListTickerRegistedController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Danh sách phiếu đã đăng ký",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.toNamed(Routes.CUSTOMER_PAGE);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    var items = controller.listTickerRegisted;
                    return controller.isLoad.value
                        ? ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) => Card(
                              shadowColor: Colors.grey,
                              elevation: 10,
                              shape: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orangeAccent,
                                ),
                              ),
                              child: ListTile(
                                onTap: () async {
                                  var result = await Get.toNamed(
                                    Routes.DETAILS_LIST_TICKER_OF_CUSTOMER,
                                    arguments: items[index],
                                  );
                                  if (result == true && result is bool) {
                                    controller.getListRegistedCustomer();
                                  }
                                },
                                title: Row(
                                  children: [
                                    Text(
                                      "${items[index].pdriverInOutWarehouseCode}",
                                      style: TextStyle(
                                        color: items[index].giovao != null
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${items[index].khoRe!.tenKho}",
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      "${items[index].loaixe!.tenLoaiXe}",
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "${items[index].soxe}",
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "Giờ dự kiến",
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(day.format(
                                      DateTime.parse(
                                        items[index].giodukien.toString(),
                                      ),
                                    )),
                                    Text(hour.format(
                                      DateTime.parse(
                                        items[index].giodukien.toString(),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orangeAccent,
                            ),
                          );
                  }),
                ),
              ],
            )),
      ),
    );
  }
}
