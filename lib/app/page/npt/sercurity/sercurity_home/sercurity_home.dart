import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_home/controller/sercurity_controller.dart';

class SercurityPage extends GetView<SercurityController> {
  final String routes = "/SERCURITY_PAGE";

  const SercurityPage({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.backgroundAppbar,
        title: const Text(
          "Tbs Logistics",
          style: CustomTextStyle.tilteAppbar,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
      ),
      body: GetBuilder<SercurityController>(
        init: SercurityController(),
        builder: (controller) => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                GestureDetector(
                  onTap: () {
                    // Get.to(() => const DriverCreateRegisterScreen());

                    Get.toNamed(Routes.SERCURITY_LIST_DANGTAI);
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      // color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.orangeAccent.withOpacity(0.6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.create_outlined, size: 30),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          "Danh sách đăng tài",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.width * 0.1),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.SERCURITY_SCREEN);
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      // color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.orangeAccent.withOpacity(0.6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.create_outlined, size: 30),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          "Quét mã kiểm tra xe vào/ra",
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
                SizedBox(height: size.width * 0.1),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.SERCURITY_RE_PASSWORD);
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      // color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.orangeAccent.withOpacity(0.6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.create_outlined, size: 30),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          "Cập nhật mật khẩu",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
