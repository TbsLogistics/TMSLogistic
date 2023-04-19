import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/change_password/change_password.dart';
import 'package:tbs_logistics_tms/app/tms/controller/tms_controller.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var now = DateTime.now();
    var a = DateFormat("a");
    var hour = DateFormat("HH");
    return GetBuilder<TmsController>(
      init: TmsController(),
      builder: (controller) => Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Container(
                  height: size.height * 0.25,
                  width: size.width,
                  color: Colors.orangeAccent.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                height: size.height * 0.1,
                                width: size.height * 0.1,
                                child: CircleAvatar(
                                  backgroundColor: Colors.brown.shade800,
                                  child: const Text('AH'),
                                )),
                            int.parse(hour.format(
                                            DateTime.parse(now.toString()))) <=
                                        18 &&
                                    int.parse(hour.format(
                                            DateTime.parse(now.toString()))) >=
                                        6
                                ? Container(
                                    child: const Center(
                                      child: Icon(
                                        Icons.brightness_1_rounded,
                                        size: 45,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Container(
                                    child: const Center(
                                      child: Icon(
                                        Icons.dark_mode_rounded,
                                        color: Colors.black,
                                        size: 45,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Center(
                                child: Text(
                                  "Họ và tên :  ${controller.user.value.fullName}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Center(
                                child: Text(
                                  "Số điện thoại : ${hour.format(DateTime.parse(now.toString()))}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    onTap: () async {
                      await SharePerApi().postLogout();
                    },
                    title: const Text(
                      "Đăng xuất",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: const Icon(
                      Icons.logout_outlined,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => ChangePasswordScreen());
                    },
                    title: const Text(
                      "Đổi mật khẩu",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: const Icon(
                      Icons.language_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}