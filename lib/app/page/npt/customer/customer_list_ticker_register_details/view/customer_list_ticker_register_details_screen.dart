import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_ticker_registed/model/list_registed_of_customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_ticker_register_details/controller/customer_list_ticker_register_details_controller.dart';

class CustomerListTickerRegisterDetailsScreen
    extends GetView<CustomerListTickerRegisterDetailsController> {
  const CustomerListTickerRegisterDetailsScreen({super.key});
  final String routes = "/DETAILS_LIST_TICKER_OF_CUSTOMER";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CustomerListTickerRegisterDetailsController>(
        init: CustomerListTickerRegisterDetailsController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text(
                  'Chi tiết đơn hàng',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Obx(() {
                    var lengthTracking =
                        controller.listTracking.value.trackingtime!.length;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.album_outlined,
                                      color: Colors.greenAccent,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${controller.listTracking.value.trackingtime![lengthTracking - 1].statustracking!.name}",
                                      style: CustomTextStyle.contentDetails,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildNameDriver(
                            controller.listTracking.value, size, context),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildNumberCar(
                            controller.listTracking.value, size, context),
                        const SizedBox(
                          height: 15,
                        ),

                        //number cont
                        _buildNumberCont(
                            controller.listTracking.value, size, context),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ));
  }

  Widget _buildNameDriver(ListRegisterDriverOfCustomerModel items, Size size,
      BuildContext context) {
    return Container(
      height: size.width * 0.2,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.orangeAccent,
        ),
        borderRadius: BorderRadius.circular(15),
        // color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Tên tài xế",
                      style: CustomTextStyle.titleDetails,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "${items.taixeRe!.tenTaixe}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const VerticalDivider(
            width: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.orangeAccent,
            thickness: 1,
          ),
          Expanded(
            child: Column(
              children: [
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Số điện thoại",
                      style: CustomTextStyle.titleDetails,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "${items.taixeRe!.phone}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberCar(ListRegisterDriverOfCustomerModel items, Size size,
      BuildContext context) {
    return Container(
      height: size.width * 0.2,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.orangeAccent,
        ),
        borderRadius: BorderRadius.circular(15),
        // color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Loại xe",
                      style: CustomTextStyle.titleDetails,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "${items.loaixeRe!.tenLoaiXe}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const VerticalDivider(
            width: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.orangeAccent,
            thickness: 1,
          ),
          Expanded(
            child: Column(
              children: [
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Số xe",
                      style: CustomTextStyle.titleDetails,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "${items.phieuvao!.soxe}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberCont(ListRegisterDriverOfCustomerModel items, Size size,
      BuildContext context) {
    return Container(
      height: size.width * 0.7,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.orangeAccent,
        ),
        borderRadius: BorderRadius.circular(15),
        // color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Số công 1",
                        style: CustomTextStyle.titleDetails,
                      ),
                      const SizedBox(height: 5),
                      Text("${items.phieuvao!.socont1}"),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Số seal 1",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${items.phieuvao!.cont1seal1}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Số seal 2",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${items.phieuvao!.cont1seal2}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Số Kiện",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${items.phieuvao!.soKien}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Số Book",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${items.phieuvao!.soBook}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Số Khối",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${items.phieuvao!.sokhoi}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            width: 1,
            indent: 15,
            endIndent: 15,
            color: Colors.orangeAccent,
            thickness: 1,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Số công 2",
                        style: CustomTextStyle.titleDetails,
                      ),
                      const SizedBox(height: 5),
                      Text("${items.phieuvao!.socont1}"),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Số seal 1",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${items.phieuvao!.cont2seal1}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Số seal 2",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${items.phieuvao!.cont2seal2}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Số Kiện",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${items.phieuvao!.sokien1}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Số Book",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${items.phieuvao!.soBook1}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Số Khối",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${items.phieuvao!.sokhoi1}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
