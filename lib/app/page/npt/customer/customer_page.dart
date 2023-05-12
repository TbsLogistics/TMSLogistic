import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/controller/customer_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/view/customer_screen.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final String routes = "/CUSTOMER_PAGE";
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CustomerController>(
      init: CustomerController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 24,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "ĐĂNG TÀI KHÁCH HÀNG",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: CustomColor.backgroundAppbar,
        ),
        body: const CustomerScreen(),
      ),
    );
  }
}
