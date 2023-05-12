import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: Theme.of(context).backgroundColor,
      height: size.height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage(
                    "assets/images/background.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: size.width * 0.1),
            Card(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.REGISTER_CUSTOMER);
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).backgroundColor,

                    border: Border.all(
                      width: 1,
                      color: Colors.orangeAccent.withOpacity(0.6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Text(
                        "Đăng ký phiếu vào",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.width * 0.1),
            Card(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.LIST_DRIVER_BY_CUSTOMER);
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).backgroundColor,

                    border: Border.all(
                      width: 1,
                      color: Colors.orangeAccent.withOpacity(0.6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Text(
                        "Danh sách tài xế ",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.width * 0.1),
            Card(
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.LIST_TICKER_CUSTOMER);
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).backgroundColor,

                    border: Border.all(
                      width: 1,
                      color: Colors.orangeAccent.withOpacity(0.6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Text(
                        "Danh sách đã đăng ký",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
