import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/widget/custom_list_title_register.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_ticker_registed/controller/customer_list_ticker_registed_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/model/list_tracking_model.dart';

class CustomerListTickerRegisted
    extends GetView<CustomerListTickerRegistedController> {
  final String routes = "/LIST_TICKER_CUSTOMER";

  const CustomerListTickerRegisted({super.key});
  @override
  Widget build(BuildContext context) {
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
              Get.back();
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: FutureBuilder(
              future: controller.getListRegistedCustomer(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var items = snapshot.data as List<ListTrackingModel>;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) => CustomListTitleRegisted(
                      stt: "${index + 1}",
                      name: "${items[index].taixeRe!.tenTaixe}",
                      phone: "${items[index].taixeRe!.phone}",
                      warehome: "${items[index].phieuvao!.kho!.tenKho}",
                      itemstype: "${items[index].loaihang!.tenLoaiHang}",
                      onTap: () {
                        Get.toNamed(
                          Routes.DETAILS_LIST_TICKER_OF_CUSTOMER,
                          arguments: items[index],
                        );
                      },
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orangeAccent,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
