import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register_details/controller/customer_create_register_details_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_register_for_driver_model.dart';

class CustomerRegisterDetailScreen
    extends GetView<CustomerRegisterDetailsController> {
  const CustomerRegisterDetailScreen({super.key});
  final String routes = "/DETAILS_REGISTER_CUSTOMER";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var day = DateFormat("dd-MM-yyyy");
    var hour = DateFormat("hh:mm a");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết phiếu",
          style: CustomTextStyle.tilteAppbar,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: CustomColor.backgroundAppbar,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.CUSTOMER_PAGE);
            },
            icon: const Icon(
              Icons.home,
              size: 25,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: GetBuilder(
          init: CustomerRegisterDetailsController(),
          builder: (controller) => Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    children: [
                      _buildDayTime(controller.detailsTicker.value, size, day,
                          hour, context),
                      const SizedBox(height: 10),
                      _buildNumberCar(
                        items: controller.detailsTicker.value,
                        size: size,
                        context: context,
                        content: controller.detailsTicker.value.loaixe == "tai"
                            ? "Xe tải"
                            : "Xe container",
                        title: 'Loại xe',
                        title2: 'Số xe',
                        content2:
                            controller.detailsTicker.value.soxe.toString(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _buildNumberCar(
                        items: controller.detailsTicker.value,
                        size: size,
                        context: context,
                        content:
                            controller.detailsTicker.value.maloaiHang == "HN"
                                ? "Hàng nhập"
                                : "Hàng xuất",
                        title: 'Loại Hàng',
                        title2: 'Kho',
                        content2: controller.detailsTicker.value.kho.toString(),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       child: CustomTextField(
                      //         title: 'Loại hàng',
                      //         content: '${items.maloaiHang}',
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 10),
                      Divider(
                        indent: size.width * 0.15,
                        endIndent: size.width * 0.15,
                        height: 2,
                        thickness: 2,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      const SizedBox(height: 10),
                      _buildNumberCont(
                          controller.detailsTicker.value, size, context),
                    ],
                  ),
                )),
              )),
    );
  }

  Widget _buildNumberCont(
      CustomerRegisterForDriverModel items, Size size, BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.orangeAccent)),
      shadowColor: Colors.grey,
      elevation: 10,
      child: SizedBox(
        height: size.width * 0.7,
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
                          style: CustomTextStyle.titlePrimary,
                        ),
                        Text(
                          "${items.socont1}",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
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
                            children: const [
                              Text(
                                "Số seal 1",
                                style: CustomTextStyle.titlePrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${items.cont1seal1}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
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
                            children: const [
                              Text(
                                "Số seal 2",
                                style: CustomTextStyle.titlePrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${items.cont1seal2}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
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
                            children: const [
                              Text(
                                "Số Kiện",
                                style: CustomTextStyle.titlePrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${items.soKien}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
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
                            children: const [
                              Text(
                                "Số Book",
                                style: CustomTextStyle.titlePrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${items.soBook}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
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
                            children: const [
                              Text(
                                "Số Khối",
                                style: CustomTextStyle.titlePrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${items.sokhoi}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
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
                          style: CustomTextStyle.titlePrimary,
                        ),
                        Text(
                          "${items.socont1}",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
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
                            children: const [
                              Text(
                                "Số seal 1",
                                style: CustomTextStyle.titlePrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${items.cont2seal1}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
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
                            children: const [
                              Text(
                                "Số seal 2",
                                style: CustomTextStyle.titlePrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${items.cont2seal2}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
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
                            children: const [
                              Text(
                                "Số Kiện",
                                style: CustomTextStyle.titlePrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${items.sokien1}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
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
                            children: const [
                              Text(
                                "Số Book",
                                style: CustomTextStyle.titlePrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${items.soBook1}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
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
                            children: const [
                              Text(
                                "Số Khối",
                                style: CustomTextStyle.titlePrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${items.sokhoi1}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
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
      ),
    );
  }

  Widget _buildNumberCar(
      {required CustomerRegisterForDriverModel items,
      required Size size,
      required BuildContext context,
      required String title,
      required String content,
      required String title2,
      required String content2}) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.orangeAccent)),
      shadowColor: Colors.grey,
      elevation: 10,
      child: SizedBox(
        height: size.width * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        title,
                        style: CustomTextStyle.titlePrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorLight,
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
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        title2,
                        style: CustomTextStyle.titlePrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        content2,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayTime(CustomerRegisterForDriverModel items, Size size,
      DateFormat day, DateFormat hour, BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.orangeAccent)),
      shadowColor: Colors.grey,
      elevation: 10,
      child: SizedBox(
        height: size.width * 0.15,
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
                        "Ngày dự kiến",
                        style: CustomTextStyle.titlePrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        day.format(DateTime.parse(items.giodukien!)),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorLight,
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
                        "Giờ dự kiến",
                        style: CustomTextStyle.titlePrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        hour.format(DateTime.parse(items.giodukien!)),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
